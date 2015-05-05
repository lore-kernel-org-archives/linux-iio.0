Return-Path: <daniel.baluta@intel.com>
Message-ID: <55489EC7.7070301@intel.com>
Date: Tue, 05 May 2015 13:43:19 +0300
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
CC: Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, Denis CIOCCA <denis.ciocca@st.com>,
 Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] iio: make tools more cross-compilation friendly
References: <1430815332-26812-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1430815332-26812-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 05/05/2015 11:42 AM, Linus Walleij wrote:
> When cross-compiling the IIO tools we need to opportunity to
> specify a cross compiler prefix and some extra CFLAGS. This
> patch enables this in the same way as for other stuff in
> tools.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>   tools/iio/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index bf7ae6d6612a..3a7a54f59713 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,5 +1,5 @@
> -CC = gcc
> -CFLAGS = -Wall -g -D_GNU_SOURCE
> +CC = $(CROSS_COMPILE)gcc
> +CFLAGS += -Wall -g -D_GNU_SOURCE
>
>   all: iio_event_monitor lsiio generic_buffer
>
>
