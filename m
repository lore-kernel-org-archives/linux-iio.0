Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:33529 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbbEVG5O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2015 02:57:14 -0400
MIME-Version: 1.0
In-Reply-To: <20150522015615.GA3320@kroah.com>
References: <1432254645-5349-1-git-send-email-ktsai@capellamicro.com>
	<20150522015615.GA3320@kroah.com>
Date: Fri, 22 May 2015 09:57:12 +0300
Message-ID: <CAEnQRZBxX-YxU1u8PuE_8ApBpsEOU9XenFyhbKUbmTW4RzO+=w@mail.gmail.com>
Subject: Re: [PATCH 1/6] iio: light: Updated Vishay Capella cm32181 ambient
 light sensor driver. - Renamed company name. - Removed cm32181_reg. - Removed
 white space. - Removed unused include files. - Updated macro definitions. -
 Renamed cm32181_chip pointer to chip.
From: Daniel Baluta <daniel.baluta@intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, May 22, 2015 at 4:56 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Thu, May 21, 2015 at 05:30:40PM -0700, Kevin Tsai wrote:
>> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
>> ---
>
> Your whole changelog ended up in the Subject line :(

Hi Kevin,

Few comments:

1) Please also add a cover letter. Use --cover-letter parameter of git
format-patch.
2) Please create a patch for each logical change. Your current 1/6
patch should be
split in several small patches:
 * 1/6 iio: light: cm32181: Update company name
 * 2/6 iio: light: cm32181: Remove unused include files
 * etc.
3) Please use specific wordings for commit subject. A subject like this:

"Updated Vishay Capella cm32181 ambient light sensor driver" doesn't say much.

thanks,
Daniel.
