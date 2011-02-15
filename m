Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4D5A6B5B.7010704@analog.com>
Date: Tue, 15 Feb 2011 13:02:35 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: michael.hennerich@analog.com
MIME-Version: 1.0
To: Shubhrajyoti <shubhrajyoti@ti.com>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: ADC: New driver for the AD7298 8-channel SPI ADC
References: <1297692220-30306-1-git-send-email-michael.hennerich@analog.com> <4D5A67DE.2030906@ti.com>
In-Reply-To: <4D5A67DE.2030906@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

Hi Shubhrajyoti,

On 02/15/2011 12:47 PM, Shubhrajyoti wrote:
> Hi Michael,
>   
>> +static IIO_DEV_ATTR_IN_RAW(6, ad7298_scan, 6);
>> +static IIO_DEV_ATTR_IN_RAW(7, ad7298_scan, 7);
>> +
>> +static ssize_t ad7298_show_temp(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             char *buf)
>> +{
>> +     /* Driver currently only support internal vref */
>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +     struct ad7298_state *st = iio_dev_get_devdata(dev_info);
>> +     unsigned short tmp;
>> +     char sign;
>> +
>> +     tmp = cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
>> +                       AD7298_TAVG | st->ext_ref);
>>     
> didnt understand why you needed the  cpu_to_be16 here?
>   
The AD7298, like almost any SPI slave device, uses MSB first.
tmp is type unsigned short. SPI uses 8-bit transfers by default.
The pointer to tmp is handed to spi_write. So on a little endian machine
it would transfer the low byte instead of high byte first.

cpu_to_be16() flips the byte order on LE and does nothing on BE.

>> +
>> +     spi_write(st->spi, (u8 *)&tmp, 2);
>> +     tmp = 0;
>> +     spi_write(st->spi, (u8 *)&tmp, 2);
>> +     usleep_range(101, 1000); /* sleep>  100us */
>> +     spi_read(st->spi, (u8 *)&tmp, 2);
>> +
>> +     tmp = be16_to_cpu(tmp)&  RES_MASK(AD7298_BITS);
>> +
>> +     /*
>> +      * One LSB of the ADC corresponds to 0.25 deg C.
>> +      * The temperature reading is in 12-bit twos complement format
>> +      */
>> +
>> +     if (tmp&  (1<<  (AD7298_BITS - 1))) {
>> +             tmp = (1<<  AD7298_BITS) - tmp;
>> +             sign = '-';
>> +     } else {
>> +             sign = '+';
>> +     }
>> +
>> +     return sprintf(buf, "%c%d.%.2d\n", sign, tmp / 4, (tmp&  3) * 25);
>> +}
>> +
>> +static IIO_DEVICE_ATTR(temp, S_IRUGO, ad7298_show_temp, NULL, 0);
>>
>>     
> <snip>
>   
>> +
>> +static int ad7298_remove(struct spi_device *spi)
>>     
> May consider __devexit
>   
Good catch.
>> +{
>> +     struct ad7298_state *st = spi_get_drvdata(spi);
>> +     struct iio_dev *indio_dev = st->indio_dev;
>> +
>> +     iio_ring_buffer_unregister(indio_dev->ring);
>> +             ad7298_ring_cleanup(indio_dev);
>> +     iio_device_unregister(indio_dev);
>> +     if (!IS_ERR(st->reg)) {
>> +             regulator_disable(st->reg);
>> +             regulator_put(st->reg);
>> +     }
>> +     kfree(st);
>> +     return 0;
>> +}
>> +
>> +static const struct spi_device_id ad7298_id[] = {
>> +     {"ad7298", 0},
>> +     {}
>> +};
>> +
>> +static struct spi_driver ad7298_driver = {
>> +     .driver = {
>> +             .name   = "ad7298",
>> +             .bus    =&spi_bus_type,
>> +             .owner  = THIS_MODULE,
>> +     },
>> +     .probe          = ad7298_probe,
>> +     .remove         = __devexit_p(ad7298_remove),
>> +     .id_table       = ad7298_id,
>> +};
>> +
>> +static int __init ad7298_init(void)
>> +{
>> +     return spi_register_driver(&ad7298_driver);
>> +}
>> +module_init(ad7298_init);
>> +
>> +static void __exit ad7298_exit(void)
>> +{
>> +     spi_unregister_driver(&ad7298_driver);
>> +}
>>     
> <snip>
>   
>> +             ret = -ENOMEM;
>> +             goto error_ret;
>> +     }
>> +     ret = ring->access.read_last(ring, (u8 *) ring_data);
>> +     if (ret)
>> +             goto error_free_ring_data;
>> +
>> +     ret = be16_to_cpu(ring_data[ch]);
>> +
>> +error_free_ring_data:
>> +     kfree(ring_data);
>> +error_ret:
>> +     return ret;
>> +}
>> +
>> +/**
>> + * ad7298_ring_preenable() setup the parameters of the ring before enabling
>> + *
>> + * The complex nature of the setting of the nuber of bytes per datum is due
>>     
> typo number.
>   
Thanks
>> + * to this driver currently ensuring that the timestamp is stored at an 8
>> + * byte boundary.
>> + **/
>> +static int ad7298_ring_preenable(struct iio_dev *indio_dev)
>> +{
>> +     struct ad7298_state *st = indio_dev->dev_data;
>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>> +     size_t d_size;
>> +     int i, m;
>> +     unsigned short command;
>> +
>> +     d_size = ring->scan_count *
>> +              (AD7298_STORAGE_BITS / 8) + sizeof(s64);
>> +
>> +     if (d_size % sizeof(s64))
>> +             d_size += sizeof(s64) - (d_size % sizeof(s64));
>> +
>> +     if (ring->access.set_bytes_per_datum)
>> +             ring->access.set_bytes_per_datum(ring, d_size);
>> +
>> +     st->d_size = d_size;
>> +
>> +     command = AD7298_WRITE | st->ext_ref;
>> +
>> +     for (i = 0, m = AD7298_CH0; i<  AD7298_MAX_CHAN; i++, m>>= 1)
>> +             if (ring->scan_mask&  (1<<  i))
>> +                     command |= m;
>> +
>> +     st->tx_buf[0] = cpu_to_be16(command);
>> +
>> +     /* build spi ring message */
>> +     st->ring_xfer[0].tx_buf =&st->tx_buf[0];
>> +     st->ring_xfer[0].len = 2;
>> +     st->ring_xfer[0].cs_change = 1;
>> +     st->ring_xfer[1].tx_buf =&st->tx_buf[1];
>> +     st->ring_xfer[1].len = 2;
>> +     st->ring_xfer[1].cs_change = 1;
>> +
>> +     spi_message_init(&st->ring_msg);
>> +     spi_message_add_tail(&st->ring_xfer[0],&st->ring_msg);
>> +     spi_message_add_tail(&st->ring_xfer[1],&st->ring_msg);
>> +
>> +     for (i = 0; i<  ring->scan_count; i++) {
>> +             st->ring_xfer[i + 2].rx_buf =&st->rx_buf[i];
>> +             st->ring_xfer[i + 2].len = 2;
>> +             st->ring_xfer[i + 2].cs_change = 1;
>> +             spi_message_add_tail(&st->ring_xfer[i + 2],&st->ring_msg);
>> +     }
>> +     /* make sure last transfer cs_change is not set */
>> +     st->ring_xfer[i + 1].cs_change = 0;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * ad7298_poll_func_th() th of trigger launched polling to ring buffer
>> + *
>> + * As sampling only occurs on spi comms occuring, leave timestamping until
>> + * then.  Some triggers will generate their own time stamp.  Currently
>> + * there is no way of notifying them when no one cares.
>> + **/
>> +static void ad7298_poll_func_th(struct iio_dev *indio_dev, s64 time)
>> +{
>> +     struct ad7298_state *st = indio_dev->dev_data;
>> +
>> +     schedule_work(&st->poll_work);
>> +     return;
>> +}
>> +/**
>> + * ad7298_poll_bh_to_ring() bh of trigger launched polling to ring buffer
>> + * @work_s:  the work struct through which this was scheduled
>> + *
>> + * Currently there is no option in this driver to disable the saving of
>> + * timestamps within the ring.
>> + * I think the one copy of this at a time was to avoid problems if the
>> + * trigger was set far too high and the reads then locked up the computer.
>> + **/
>> +static void ad7298_poll_bh_to_ring(struct work_struct *work_s)
>> +{
>> +     struct ad7298_state *st = container_of(work_s, struct ad7298_state,
>> +                                               poll_work);
>> +     struct iio_dev *indio_dev = st->indio_dev;
>> +     struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>> +     s64 time_ns;
>> +     __u16 buf[16];
>>     
> Any reason for using __u16
>   
No
>> +     int b_sent, i;
>> +
>> +     /* Ensure only one copy of this function running at a time */
>> +     if (atomic_inc_return(&st->protect_ring)>  1)
>> +             return;
>> +
>> +     b_sent = spi_sync(st->spi,&st->ring_msg);
>>     
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
