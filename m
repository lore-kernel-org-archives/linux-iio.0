Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52467 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcFKQ6E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 Jun 2016 12:58:04 -0400
Subject: Re: [PATCH] staging: iio: fix ad7606_spi regression
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>
References: <1464616249-3523805-1-git-send-email-arnd@arndb.de>
 <CAMuHMdUxaSwoabbFP0Q4gOGoE5bq0RkOUPoyF7Z_XF6e9=GsBg@mail.gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Ioana Ciornei <ciorneiioana@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	linux-iio@vger.kernel.org,
	driverdevel <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0e594d6f-d228-030c-7670-3a40459c6ab9@kernel.org>
Date: Sat, 11 Jun 2016 17:58:01 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUxaSwoabbFP0Q4gOGoE5bq0RkOUPoyF7Z_XF6e9=GsBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/05/16 14:54, Geert Uytterhoeven wrote:
> On Mon, May 30, 2016 at 3:50 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> As pointed out by Geert Uytterhoeven, the patch was incorrect
>> and breaks the driver, which was fortunately pointed out by
>> this gcc warning:
>>
>> drivers/staging/iio/adc/ad7606_spi.c: In function ‘ad7606_spi_read_block’:
>> drivers/staging/iio/adc/ad7606_spi.c:34: warning: ‘data’ is used uninitialized in this function
>>
>> The effect of the patch is that the data is copied into
>> a random memory location (from the uninitialized pointer)
>> instead of being byteswapped in place.
>>
>> This adds the initialization for the 'data' variable back
>> to restore the original behavior.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
>> Fixes: 87787e5ef727 ("Staging: iio: Fix sparse endian warning")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

