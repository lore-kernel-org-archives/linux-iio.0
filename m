Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-201.synserver.de ([212.40.185.201]:1399 "EHLO
	smtp-out-201.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab3JIGhR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Oct 2013 02:37:17 -0400
Message-ID: <5254FA14.7090603@metafoo.de>
Date: Wed, 09 Oct 2013 08:39:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: crzy <chskr1016@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: change device attributes dynamically
References: <loom.20131008T094235-776@post.gmane.org> <loom.20131009T055541-305@post.gmane.org>
In-Reply-To: <loom.20131009T055541-305@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/09/2013 05:56 AM, crzy wrote:
> crzy <chskr1016@...> writes:
> 
>>
>> I want to change device attributes at /sys/iio..... for AD-FMCOMMS1-
> EBZ.When 
>> will the driver detects the value is changed?will the driver dynamically 
>> detects them ?
>> i want to change values dynamically like
>> echo 500000000 > out_altvoltage1_DAC_CLK_frequency
>>
>>
> 
> 
> when will the device reads register value? i mean when will device changes 
> its clk frequency?
> Plz tell me how this process takes place

Hi,

The device's registers are updates as soon as you write to the sysfs file.

- Lars

