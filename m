Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59476 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbC1LOT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2015 07:14:19 -0400
Message-ID: <55168D09.1020205@kernel.org>
Date: Sat, 28 Mar 2015 11:14:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Robert Dolca <robert.dolca@intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH] IIO: Add support for L3GD20H gyroscope
References: <1427118025-4380-1-git-send-email-robert.dolca@intel.com>	<1427118025-4380-2-git-send-email-robert.dolca@intel.com> <CACRpkdb1s1_5RUixwf52F0vKkrEwa15CjFHV75=0UnSOyx+xPg@mail.gmail.com>
In-Reply-To: <CACRpkdb1s1_5RUixwf52F0vKkrEwa15CjFHV75=0UnSOyx+xPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/15 10:29, Linus Walleij wrote:
> On Mon, Mar 23, 2015 at 2:40 PM, Robert Dolca <robert.dolca@intel.com> wrote:
> 
>> It can be used exactly like L3GD20 but it has a different WhoAmI
>> register value.
>>
>> Signed-off-by: Robert Dolca <robert.dolca@intel.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Yours,
> Linus Walleij
> 
Applied to the togreg branch of iio.git initially pushed out as testing
for the autobuilders to play.

I'll hold off on the other patch until that discussion is resolved!

Jonathan
