Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:29281 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753479AbcD0Q63 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Apr 2016 12:58:29 -0400
Subject: Re: [PATCH] iio: tmp006: Set correct iio name
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Yong Li <sdliyong@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>
References: <1461296584-11918-1-git-send-email-sdliyong@gmail.com>
 <43150fbd-37ac-2d51-dd87-f41670417b96@kernel.org> <571E854A.90404@gmail.com>
 <7621197a-95ed-239e-8baa-83014bc27a26@kernel.org>
 <571F49B0.4060407@metafoo.de>
 <CADO9-peu32UCxaep8yZUD6XW=ABLGiTYuQJewn-C3Gedc2JewA@mail.gmail.com>
 <571F588D.3010800@metafoo.de>
 <CADO9-peqytsYKxVCsEbYt_fLKH3CaiAeQzfgvA+4CsP6u2yJOQ@mail.gmail.com>
 <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	=?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski@samsung.com>,
	Matt Ranostaj <mranostay@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <5720EFAA.3040407@intel.com>
Date: Wed, 27 Apr 2016 19:58:18 +0300
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCkcwDUPZHpEOTzcHxQ23xgq429fJQg63s5TUi0w69iWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/26/2016 06:21 PM, Daniel Baluta wrote:
> On Tue, Apr 26, 2016 at 4:14 PM, Yong Li <sdliyong@gmail.com> wrote:
>> I am thinking if there is any application is using this incorrect
>> name, the application should be fix too
> 
> The rule is: "Don't break the userspace ABI". So, if we got this wrong
> from the beginning we are stuck with this name.
> 
> The only thing that can save the situation is to know that there is no
> application relying on the name :).
> 
But if iio_dev->name is supposed to be the "model name" then setting it
to the i2c dev_name is just plain wrong, right? Correcting this could be
considered a bugfix.

There are also other ways to deal with this in userspace. Perhaps you
could look at $(basename $(readlink /sys/bus/i2c/devices/*/driver))?

-- 
Regards,
Leonard
