Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:35417 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbbGPNal (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2015 09:30:41 -0400
MIME-Version: 1.0
In-Reply-To: <18BF4A9F-0C9F-4DB6-9F4D-E91A904DBBB1@kernel.org>
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
	<1436885814-29155-4-git-send-email-daniel.baluta@intel.com>
	<18BF4A9F-0C9F-4DB6-9F4D-E91A904DBBB1@kernel.org>
Date: Thu, 16 Jul 2015 16:30:39 +0300
Message-ID: <CAEnQRZCn4ZrM0=uODPXgP6M96jSNpDOaOVJC7qZtL1irEQA=tw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: magnetometer: mmc35240: fix SET/RESET sequence
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>, viorel.suman@intel.com,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 14, 2015 at 11:04 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>
>
> On 14 July 2015 15:56:54 BST, Daniel Baluta <daniel.baluta@intel.com> wrote:
>>From: Viorel Suman <viorel.suman@intel.com>
>>
>>The RESET operation invoked in the last instance will align
>>in the natural way all 3 axis and the chip top view.
> What is the result of the bug?
> Just trying to assess urgency of the patch!

Compass app shows North and South switched. This can be corrected
from mounting matrix though.

Daniel.
