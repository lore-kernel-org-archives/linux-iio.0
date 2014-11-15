Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:48281 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754262AbaKOSHa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Nov 2014 13:07:30 -0500
Message-ID: <546795FB.6070604@imgtec.com>
Date: Sat, 15 Nov 2014 15:05:47 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Andrew Bresticker <abrestic@chromium.org>,
	James Hartley <james.hartley@imgtec.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <Pawel.Moll@arm.com>, <Mark.Rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<Naidu.Tellapati@imgtec.com>, Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH v3 1/3] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1415888044-16635-1-git-send-email-ezequiel.garcia@imgtec.com> <1415888044-16635-2-git-send-email-ezequiel.garcia@imgtec.com> <54672F04.40201@kernel.org>
In-Reply-To: <54672F04.40201@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 11/15/2014 07:46 AM, Jonathan Cameron wrote:
> On 13/11/14 14:13, Ezequiel Garcia wrote:
>> From: Phani Movva <Phani.Movva@imgtec.com>
>>
>> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
>>
>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> [Ezequiel: code style cleaning]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> Looks good.  I'll just give Rob time to take another look at the device
> tree bindings before taking this.
> 

Sounds good. Thanks!
-- 
Ezequiel
