Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:39603 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab0ENLhe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2010 07:37:34 -0400
Message-ID: <4BED3644.9030408@cam.ac.uk>
Date: Fri, 14 May 2010 12:38:44 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: uclinux-dist-devel <uclinux-dist-devel@blackfin.uclinux.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: max1363 driver comments
References: <544AC56F16B56944AEC3BD4E3D5917712E568FC025@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E568FC025@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,
> 
> /* Todo: test this */
> int max1363_single_channel_from_ring(long mask, struct max1363_state *st)
> {
>         unsigned long numvals;
>         int count = 0, ret;
>         u8 *ring_data;
>         if (!(st->current_mode->modemask & mask)) {
>                 ret = -EBUSY;
>                 goto error_ret;
>         }
>         numvals = hweight_long(st->current_mode->modemask);
> 
>         ring_data = kmalloc(numvals*2, GFP_KERNEL);
>         if (ring_data == NULL) {
>                 ret = -ENOMEM;
>                 goto error_ret;
>         }
>         ret = st->indio_dev->ring->access.read_last(st->indio_dev->ring,
>                                                 ring_data);
>         if (ret)
>                 goto error_free_ring_data;
>         /* Need a count of channels prior to this one */
>         mask >>= 1;
>         while (mask) {
>                 if (mask && st->current_mode->modemask)
>                         count++;
>                 mask >>= 1;
>         }
>         if (st->chip_info->bits != 8)
>                 return ((int)(ring_data[count*2 + 0] & 0x0F) << 8)
>                         + (int)(ring_data[count*2 + 1]);
>         else
>                 return ring_data[count];
> 
> error_free_ring_data:
>         kfree(ring_data);
> error_ret:
>         return ret;
> }
> 
> 1) Where does ring_data get freed?
Good point.  i really should have looked at this more carefully.

I guess at somepoint I took that dynamic and clean forgot to change the exit path
appropriately.

> 2) if (mask && st->current_mode->modemask)? Shouldn't this be a Bitwise AND & ?
Yes.
> 
> 
> static int __devinit max1363_probe(struct i2c_client *client,
>                                    const struct i2c_device_id *id)
> {
> 
> [--snip--]
> 
>         /* Find the chip model specific data */
>         for (i = 0; i < ARRAY_SIZE(max1363_chip_info_tbl); i++)
>                 if (!strcmp(max1363_chip_info_tbl[i].name, id->name)) {
>                         st->chip_info = &max1363_chip_info_tbl[i];
>                         break;
>                 };
> 
> Isn't this what id->driver_data is for?
> 
> st->chip_info = &max1363_chip_info_tbl[id->driver_data];
> 
> In case you want to make this bullet prove - use distinct offsets.
Also a good point.  Ouch that piece of stupidity has been
there a very long time. Might be worth squashing the name field
in that structure as well. Can easily get that from the id table.
> See example below.
> 
> /* max1363 and max1368 tested - rest from data sheet */
> static const struct max1363_chip_info max1363_chip_info_tbl[] = {
> -       {
> +       [max1361] = {
>                 .name = "max1361",
>                 .num_inputs = 4,
>                 .bits = 10,
>                 .int_vref_mv = 2048,
>                 .monitor_mode = 1,
>                 .mode_list = max1363_mode_list,
>                 .num_modes = ARRAY_SIZE(max1363_mode_list),
>                 .default_mode = s0to3,
>                 .dev_attrs = &max1363_dev_attr_group,
>                 .scan_attrs = &max1363_scan_el_group,
>         }, {
> 
I'll put together a patch to fix these sometime in the next few days.

Thanks for taking a look at this driver.  I fear it has previously sneaked
through as the least read of all the drivers (by merit of being complex
and rather dull!)

Jonathan
