Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58528 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbcFJHuH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Jun 2016 03:50:07 -0400
Subject: Re: [PATCH] HC-SR04 ultrasonic ranger IIO driver
To: Johannes Thoma <johannes@johannesthoma.com>,
	linux-iio@vger.kernel.org
References: <1465238418-26095-1-git-send-email-johannes@johannesthoma.com>
 <5756E614.5010508@metafoo.de>
 <3fd11d4e-54c4-1589-f0ce-14554bb041c4@johannesthoma.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <575A712A.6060606@metafoo.de>
Date: Fri, 10 Jun 2016 09:50:02 +0200
MIME-Version: 1.0
In-Reply-To: <3fd11d4e-54c4-1589-f0ce-14554bb041c4@johannesthoma.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/10/2016 07:35 AM, Johannes Thoma wrote:
> Hi,
> 
> Am 07.06.16 um 17:19 schrieb Lars-Peter Clausen:
>>
>> Any new ABI needs to be documented in Documentation/ABI/...
>>
> I will move it there thanks for pointing that out.
> 
>> But to take one thing ahead passing the GPIO number (or a label) from
>> userspace is not really a good ABI in my opinion. The GPIO numbers should
>> come from the hardware description (DTS, ACPI, board file, ...)
>>
> I wanted to offer the possibility to configure the device at run time. Since
> it is not part of the board but a periphial device it could also be attached
> while the system is running. I would like to keep this interface but will
> add support for also configue it via device tree, as you suggested.

The right interface for handling re-configurable logic is devicetree
overlays. It allows you to describe the hardware using standard devicetree
descriptions but it can be loaded and unloaded on-demand at runtime.

