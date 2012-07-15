Return-Path: <knaack.h@gmx.de>
Message-ID: <50032AD8.9040103@gmx.de>
Date: Sun, 15 Jul 2012 22:40:56 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: [PATCH 0/2] fixes for adt7410
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

This patchset makes the ADT7410 usable. Main reason was the following error when trying to register one of these devices:
[  180.945561] BUG: unable to handle kernel NULL pointer dereference at   (null)
[  180.945592] IP: [<f84b1e80>] iio_device_register_eventset+0x380/0x3a0 [industrialio]
This happens, since in industrialio-events.c __iio_add_event_config_attrs (which does a INIT_LIST_HEAD) is not called, if the channels attribute of the device is not set. As a result, list_for_each_entry causes those NULL pointer dereference problems. So, before trying to access those list elements, we check for their existence (also in unregister functions).
Now the adt7410.c ended in some complex changes - my apologies for this:

  * check for exact values provided through sysfs, otherwise output a verbose error/usage message for: sample mode, resolution, event mode
  * adt7410_show_id: I don't see a point in masking out some LSBs, if they get shifted to oblivion, anyway -> no more need for ADT7410_MANUFACTORY_ID_MASK
  * adt7410_convert_temperature: in 13 bit mode, the driver assumed the data to be stored in bits 0-12, but according to the data sheet, it is stored in bits 3-15. Temperature readings were always around 200(°C), while real temperature was something around 20(°C). Simple fix: mask out bits 0-2 in 13 bit mode and use the 16 bit routines from that point on.
  * adt7410_set_t_bound: handle float values provided through sysfs properly. Also, simplify treatment of 13 bit values by masking out bits 0-2.
  * adt7410_probe, adt7410_remove: fix another possible NULL pointer dereference issue, in case no platform data is provided. Sync chip->config with the config register

Device instanciation, reading sysfs-values and removal work smoothly, now. Based on recent official git kernel.

Remaining issue: writing any value to sysfs (mode, resolution, ...) files causes infinite call of the appropriate store function. I have no clue where to look for a start. For demonstration, I added some printk's to the store function. This is a piece of the results, it keeps repeating forever:

[ 3257.158462] Set Resolution 1
[ 3257.158478] Set Resolution 2, data: 16
[ 3257.174151] Set Resolution 3, ret: 0
[ 3257.174157] Set Resolution 4, config: 0
[ 3257.174160] Set Resolution 4.2
[ 3257.182143] Set Resolution 6
[ 3257.182148] Set Resolution 7, ret: 0
[ 3257.182159] Set Resolution 1
[ 3257.182163] Set Resolution 2, data: 16
[ 3257.198140] Set Resolution 3, ret: 0
[ 3257.198145] Set Resolution 4, config: 0
[ 3257.198147] Set Resolution 4.2
[ 3257.206139] Set Resolution 6
[ 3257.206144] Set Resolution 7, ret: 0
[ 3257.206150] Set Resolution 1
[ 3257.206154] Set Resolution 2, data: 16
[ 3257.222147] Set Resolution 3, ret: 0
[ 3257.222158] Set Resolution 4, config: 0
[ 3257.222161] Set Resolution 4.2
[ 3257.230135] Set Resolution 6
[ 3257.230141] Set Resolution 7, ret: 0
[ 3257.230154] Set Resolution 1
[ 3257.230159] Set Resolution 2, data: 16
[ 3257.246132] Set Resolution 3, ret: 0
[ 3257.246137] Set Resolution 4, config: 0
[ 3257.246140] Set Resolution 4.2
[ 3257.254130] Set Resolution 6
[ 3257.254135] Set Resolution 7, ret: 0

The function looks like this:

static ssize_t adt7410_store_resolution(struct device *dev,
        struct device_attribute *attr,
        const char *buf,
        size_t len)
{
    struct iio_dev *dev_info = dev_to_iio_dev(dev);
    struct adt7410_chip_info *chip = iio_priv(dev_info);
    unsigned long data;
    u16 config;
    int ret;

    printk(KERN_ERR "Set Resolution 1\n");
    ret = strict_strtoul(buf, 10, &data);
    printk(KERN_ERR "Set Resolution 2, data: %u\n", data);
    if (ret)
        return -EINVAL;

    ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
    printk(KERN_ERR "Set Resolution 3, ret: %i\n", ret);
    if (ret)
        return -EIO;

    config = chip->config & (~ADT7410_RESOLUTION);
    printk(KERN_ERR "Set Resolution 4, config: %i\n", config);
    switch (data) {
        case 13:
            config |= 0;
            printk(KERN_ERR "Set Resolution 4.1,\n");
            break;
        case 16:
            config |= ADT7410_RESOLUTION;
            printk(KERN_ERR "Set Resolution 4.2\n");
            break;
        default:
            printk(KERN_ERR "Invalid value, valid are 13 and 16\n");
    }
/*    if (data) {
        printk(KERN_ERR "Set Resolution 5\n");
   
        config |= ADT7410_RESOLUTION;
    }
*/
    ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, config);
    printk(KERN_ERR "Set Resolution 6\n");
    if (ret)
        return -EIO;

    chip->config = config;
    printk(KERN_ERR "Set Resolution 7, ret: %i\n", ret);
   

    return ret;
}
