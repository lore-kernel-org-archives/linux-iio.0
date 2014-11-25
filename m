Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-207.synserver.de ([212.40.185.207]:1072 "EHLO
	smtp-out-207.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbaKYODw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 25 Nov 2014 09:03:52 -0500
Message-ID: <54748C48.1090608@metafoo.de>
Date: Tue, 25 Nov 2014 15:03:52 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mike Looijmans <mike.looijmans@topic.nl>, pmeerw@pmeerw.net
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: iio:adc:ad799x driver broken after commit "Write default config
 on probe and reset alert status on probe"
References: <547439F9.7070903@topic.nl>
In-Reply-To: <547439F9.7070903@topic.nl>
Content-Type: multipart/mixed;
 boundary="------------020306070503040108030209"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------020306070503040108030209
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/25/2014 09:12 AM, Mike Looijmans wrote:
> After this commit:
>
>      iio:adc:ad799x: Write default config on probe and reset alert status on
> probe
>
>      writing ALERT_EN and BUSY_ALERT to the chip config register clears
>      pending alerts, BUSY_ALERT is cleared when reading back the register
>
> The AD7999 on our board no longer functions, reading the in_voltage*_raw
> sysfiles always returns "255" after this.
>
> I reverted the commit, and that fixed the problem for me.

I suspect that there is something going wrong when reading back the config 
register, can you check the attached patch and see what the output is?

Thanks,
- Lars


--------------020306070503040108030209
Content-Type: text/x-patch;
 name="ad799x.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ad799x.patch"

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e37412d..babbdde 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -816,6 +816,8 @@ static int ad799x_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto error_disable_reg;
 	st->config = ret;
+	dev_info(&client->dev, "config: %x %x\n", st->config,
+		st->chip_config->default_config);
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);

--------------020306070503040108030209--
