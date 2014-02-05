Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:62334 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbaBESmo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2014 13:42:44 -0500
Received: by mail-pb0-f45.google.com with SMTP id un15so717554pbc.32
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2014 10:42:44 -0800 (PST)
Date: Wed, 05 Feb 2014 10:42:20 -0800
Subject: DMA sampling and IIO
From: John Syn <john3909@gmail.com>
To: <linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>
Message-ID: <CF17C5B7.1940A%john3909@gmail.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="ISO-8859-1"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I¹m working on a project that uses the ADE7878 Energy Measurement part
from Analog Devices. Currently there is an IIO device driver in the
staging/iio/meter folder, but I would like to extend this by adding high
speed sampling of the AC waveforms. The ADE7878 will continuously output
samples (8 Khz) of the voltage/current waveforms via an I2S interface. I
plan to use DMA to store these values in a buffer and then use IIO Ring
Buffer to access these values from User Space.

Was this considered in the IIO framework and does anyone have any
suggestions on how I might proceed?

Jonathan Cameron suggested I include Lars-Peter Clausen and Mark Brown in
this discussion.

Regards,

John 


