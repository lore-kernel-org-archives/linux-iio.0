Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from antcom.de ([188.40.178.216]:36907 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751425Ab2ELVoS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 12 May 2012 17:44:18 -0400
Message-ID: <4FAED9AD.4020803@antcom.de>
Date: Sat, 12 May 2012 23:44:13 +0200
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] staging:iio:dac:max517: Convert to channel spec
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-2-git-send-email-lars@metafoo.de> <4FAEB14A.8020408@kernel.org>
In-Reply-To: <4FAEB14A.8020408@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 12/05/12 20:51, Jonathan Cameron wrote:
> On 05/11/2012 06:04 PM, Lars-Peter Clausen wrote:
>> Convert the max517 driver to channel spec. As part of the conversion the
>> "out_voltage_1&2_raw" property, which updates both channel 1 and 2
>> simultaneously with the same value, is lost, since this is not really covered by
>> the IIO spec.
> We'll have to introduce a buffered option for output at somepoint to
> cover the equivalent of that out_voltage_1&2_raw attribute.
> 
> Roland, how vital was that to you?

I'm generally fine with the proposed changes and can ack it. However, we
should provide a replacement for the old "1&2" attribute. It supports a
certain hardware feature of this chip. No need to sacrifice it.

Thanks,

Roland
