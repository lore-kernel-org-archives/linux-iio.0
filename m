Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-127.synserver.de ([212.40.185.127]:1093 "EHLO
	smtp-out-127.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaKUHlQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Nov 2014 02:41:16 -0500
Message-ID: <546EEC9E.2080208@metafoo.de>
Date: Fri, 21 Nov 2014 08:41:18 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Nikolaus Schulz <nikolaus.schulz@avionic-design.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"open list:IIO SUBSYSTEM AND..." <linux-iio@vger.kernel.org>,
	Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 2/2] iio: add driver for the TI DAC8554
References: <1416502461-13980-1-git-send-email-nikolaus.schulz@avionic-design.de> <1416502461-13980-2-git-send-email-nikolaus.schulz@avionic-design.de> <alpine.DEB.2.02.1411201911001.13081@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1411201911001.13081@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/20/2014 07:19 PM, Peter Meerwald wrote:

>> +static const char * const dac8554_powerdown_modes[] = {
>> +	"hi-z",
>
> hi-z is (not yet) described in ABI/testing/sysfs-bus-iio, you should add
> that

Other drivers call it three_state, so might as well stay with that.

>
>> +	"1kohm_to_gnd",
>> +	"100kohm_to_gnd"
>> +};

