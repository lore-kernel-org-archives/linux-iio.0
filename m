Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:32808 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbcDWVoE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Apr 2016 17:44:04 -0400
Subject: Re: [RFC PATCH 3/3] Documentation: iio: Add IIO software devices docs
To: Daniel Baluta <daniel.baluta@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1461167126-23399-1-git-send-email-daniel.baluta@intel.com>
 <1461167126-23399-4-git-send-email-daniel.baluta@intel.com>
 <5717A3E6.4010200@metafoo.de>
 <CAEnQRZAstpFdr8wwNaVacVzwdTZ2M_R-c=mo4gNUHBP67R6cZw@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <15c9a1f0-dffc-63a1-0bcb-2507ed513556@kernel.org>
Date: Sat, 23 Apr 2016 22:44:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZAstpFdr8wwNaVacVzwdTZ2M_R-c=mo4gNUHBP67R6cZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/04/16 16:51, Daniel Baluta wrote:
> On Wed, Apr 20, 2016 at 6:44 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 04/20/2016 05:45 PM, Daniel Baluta wrote:
>>
>>> +
>>> +What:                /config/iio/triggers/dummy
>>
>> s/triggers/devices
> 
> :D, will fix in v2. Obviously, one problem of this RFC is that we
> have a lot of duplicate code between the triggers and devices
> in configfs support.
> 
We could take this as is, and do the refactor as a follow up series
- kind of up to you really.

The series as a whole looks pretty good to me though a bit of tidying
up is needed in one or two corners.  Will take a closer look....
