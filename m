Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46344 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbbGSKzQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 06:55:16 -0400
Message-ID: <55AB8213.2010109@kernel.org>
Date: Sun, 19 Jul 2015 11:55:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>
CC: viorel.suman@intel.com, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: magnetometer: mmc35240: fix SET/RESET sequence
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>	<1436885814-29155-4-git-send-email-daniel.baluta@intel.com>	<18BF4A9F-0C9F-4DB6-9F4D-E91A904DBBB1@kernel.org> <CAEnQRZCn4ZrM0=uODPXgP6M96jSNpDOaOVJC7qZtL1irEQA=tw@mail.gmail.com>
In-Reply-To: <CAEnQRZCn4ZrM0=uODPXgP6M96jSNpDOaOVJC7qZtL1irEQA=tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/07/15 14:30, Daniel Baluta wrote:
> On Tue, Jul 14, 2015 at 11:04 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>
>> On 14 July 2015 15:56:54 BST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>> From: Viorel Suman <viorel.suman@intel.com>
>>>
>>> The RESET operation invoked in the last instance will align
>>> in the natural way all 3 axis and the chip top view.
>> What is the result of the bug?
>> Just trying to assess urgency of the patch!
> 
> Compass app shows North and South switched. This can be corrected
> from mounting matrix though.
> 
Applied.
> Daniel.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

