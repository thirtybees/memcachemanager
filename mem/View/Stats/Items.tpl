<?php
if((isset($response)) && ($response != array()))
{ ?>
    <div class="sub-header corner full-size padding">Result</div>
    <div class="container corner full-size padding">
    <?php
    foreach($response as $server => $result)
    { ?>
        <pre style="font-size:12px;overflow:auto;" class="full-size"><?php echo htmlentities(trim($result), ENT_NOQUOTES | ENT_IGNORE, 'UTF-8'); ?></pre>
    <?php
    }
    ?>
    </div>
<?php
} ?>
    <div class="sub-header corner full-size padding">
        Items in Slab <?php echo htmlspecialchars($_GET['slab'], ENT_QUOTES, 'UTF-8'); ?>, only showing first <?php echo htmlspecialchars($_ini->get('max_item_dump'), ENT_QUOTES, 'UTF-8'); ?> items
        <span style="float:right;"><a href="?server=<?php echo htmlspecialchars(urlencode($_GET['server']), ENT_QUOTES, 'UTF-8'); ?>&amp;show=slabs">Back to Server Slabs</a></span>
    </div>
    <div class="container corner full-size padding">
<?php
$notFirst = false;

# Items
foreach($items as $key => $data)
{
    # Checking if first item
    if($notFirst) { echo '<hr/>'; }
    ?>

        <a class="green item" href="index.php?server=<?php echo htmlspecialchars(urlencode($_GET['server']), ENT_QUOTES, 'UTF-8'); ?>&amp;show=items&amp;slab=<?php echo htmlspecialchars(urlencode($_GET['slab']), ENT_QUOTES, 'UTF-8'); ?>&amp;request_key=<?php echo htmlspecialchars(urlencode($key), ENT_QUOTES, 'UTF-8'); ?>&amp;request_api=<?php echo htmlspecialchars(urlencode($_ini->get('get_api')), ENT_QUOTES, 'UTF-8'); ?>&amp;request_command=get"><?php echo htmlspecialchars(((strlen($key) > 70) ? substr($key, 0, 70) . '[..]' : $key), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?></a>

        <span class="right" style="clear:right;">
            <strong>Size</strong> : <?php echo Library_Data_Analysis::byteResize($data[0]); ?>Bytes,
            <strong>Expiration</strong> :
<?php
            # Infinite expiration
            if($data[1] == $infinite)
            {
                echo '&#8734;';
            }
            # Timestamp expiration
            else
            {
                echo Library_Data_Analysis::uptime($data[1] - time());
            } ?>
        </span>
<?php
    # First item done
    $notFirst = true;
} ?>
    </div>