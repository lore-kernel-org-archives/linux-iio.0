Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36644 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbcHZOdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2016 10:33:46 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so5001299pfg.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2016 07:33:46 -0700 (PDT)
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: temperature: fix non static symbol warnings
Date: Fri, 26 Aug 2016 14:33:20 +0000
Message-Id: <1472222000-1163-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fixes the following sparse warnings:

drivers/iio/temperature/maxim_thermocouple.c:35:28: warning:
 symbol 'max6675_channels' was not declared. Should it be static?
drivers/iio/temperature/maxim_thermocouple.c:52:28: warning:
 symbol 'max31855_channels' was not declared. Should it be static?
drivers/iio/temperature/maxim_thermocouple.c:98:38: warning:
 symbol 'maxim_thermocouple_chips' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index 030827e..39dd202 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -32,7 +32,7 @@ enum {
 	MAX31855,
 };
 
-const struct iio_chan_spec max6675_channels[] = {
+static const struct iio_chan_spec max6675_channels[] = {
 	{	/* thermocouple temperature */
 		.type = IIO_TEMP,
 		.info_mask_separate =
@@ -49,7 +49,7 @@ const struct iio_chan_spec max6675_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(1),
 };
 
-const struct iio_chan_spec max31855_channels[] = {
+static const struct iio_chan_spec max31855_channels[] = {
 	{	/* thermocouple temperature */
 		.type = IIO_TEMP,
 		.address = 2,
@@ -95,7 +95,7 @@ struct maxim_thermocouple_chip {
 	u32 status_bit;
 };
 
-const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
+static const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
 	[MAX6675] = {
 			.channels = max6675_channels,
 			.num_channels = ARRAY_SIZE(max6675_channels),



