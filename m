Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52543 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbEHSaX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:23 -0400
Message-ID: <554CCD46.1040106@kernel.org>
Date: Fri, 08 May 2015 10:50:46 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] iio: make tools more cross-compilation friendly
References: <1430815332-26812-1-git-send-email-linus.walleij@linaro.org> <55489EC7.7070301@intel.com>
In-Reply-To: <55489EC7.7070301@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/15 06:43, Daniel Baluta wrote:
> 
> 
> On 05/05/2015 11:42 AM, Linus Walleij wrote:
>> When cross-compiling the IIO tools we need to opportunity to
>> specify a cross compiler prefix and some extra CFLAGS. This
>> patch enables this in the same way as for other stuff in
>> tools.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git

Thanks,

Jonathan
> 
>> ---
>>   tools/iio/Makefile | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
>> index bf7ae6d6612a..3a7a54f59713 100644
>> --- a/tools/iio/Makefile
>> +++ b/tools/iio/Makefile
>> @@ -1,5 +1,5 @@
>> -CC = gcc
>> -CFLAGS = -Wall -g -D_GNU_SOURCE
>> +CC = $(CROSS_COMPILE)gcc
>> +CFLAGS += -Wall -g -D_GNU_SOURCE
>>
>>   all: iio_event_monitor lsiio generic_buffer
>>
>>

