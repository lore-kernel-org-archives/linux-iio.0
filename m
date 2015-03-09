Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45035 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbCIRSG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 13:18:06 -0400
Message-ID: <54FDD5CD.4050708@kernel.org>
Date: Mon, 09 Mar 2015 17:18:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 4/5] tools: iio: Define _GNU_SOURCE in Makefile
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com> <1424940567-24877-5-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-5-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/15 08:49, Roberta Dobrescu wrote:
> Definition of _GNU_SOURCE is needed to get rid of some warnings, such
> as:
> warning: implicit declaration of function `asprintf'.
> 
> generic_buffer.c and iio_event_monitor.c define _GNU_SOURCE,
> but it is also needed in lsiio.c and iio_utils.c. For this reason,
> this patch adds the definition in Makefile and removes it from where
> it already exists.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Hmm. I wondered about whether it was better to have this in the individual
files but came down in the end on the same side you did.
Cleaner in the makefile.

Applied to the togreg branch of iio.git

Thanks,
> ---
>  tools/iio/Makefile            | 2 +-
>  tools/iio/generic_buffer.c    | 2 --
>  tools/iio/iio_event_monitor.c | 2 --
>  3 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> index 83813ad..bf7ae6d 100644
> --- a/tools/iio/Makefile
> +++ b/tools/iio/Makefile
> @@ -1,5 +1,5 @@
>  CC = gcc
> -CFLAGS = -Wall -g
> +CFLAGS = -Wall -g -D_GNU_SOURCE
>  
>  all: iio_event_monitor lsiio generic_buffer
>  
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 01266c2..8f8f058 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -18,8 +18,6 @@
>   *
>   */
>  
> -#define _GNU_SOURCE
> -
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <dirent.h>
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index f19cff1..427c271 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -16,8 +16,6 @@
>   *
>   */
>  
> -#define _GNU_SOURCE
> -
>  #include <unistd.h>
>  #include <stdlib.h>
>  #include <stdbool.h>
> 

