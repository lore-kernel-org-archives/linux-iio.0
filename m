Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from fieber.vanmierlo.com ([84.243.197.177]:56571 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752550AbdF0KST (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jun 2017 06:18:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 27 Jun 2017 11:53:43 +0200
From: Maarten Brock <m.brock@vanmierlo.com>
To: linux-iio@vger.kernel.org,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>
Subject: iio:adc mcp3422 initial config
Message-ID: <64278d08a137561f241f440bb0265698@vanmierlo.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

Looking in the mcp3422.c iio kernel driver I see a few issues with the 
initialization of the config word for the adc in mcp3422_probe().

1. It uses MCP3422_CHANNEL_VALUE(1). Why is channel 2 the default?

2. It tries to set MCP3422_CONT_SAMPLING, but if this first I2C transfer 
fails it will never be set again. The initial config is not stored in 
adc->config and adc->config is uninitialized! All subsequent writes will 
leave MCP3422_CONT_SAMPLING off.

3. The return value of mcp3422_update_config() is not checked. Not sure 
if it should though. I wouldn't want a single failure to disable the 
driver. It might even be that the adc is not available yet at linux boot 
time.

Number 2 is the most important one. We saw it fail because our I2C goes 
through an FPGA which was not loaded yet.

I can write a patch, but welcome some insights first.

Kind regards,
Maarten Brock

