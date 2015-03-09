Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45080 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbbCIRX4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 13:23:56 -0400
Message-ID: <54FDD72A.8020105@kernel.org>
Date: Mon, 09 Mar 2015 17:23:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 5/5] tools: iio: lsiio: Remove unused variables
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com> <1424940567-24877-6-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-6-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/15 08:49, Roberta Dobrescu wrote:
> This patch removes unused variables from lsiio.c in order
> to get rid of the warnings regarding them.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git

Thanks again for sorting this out.

Jonathan
> ---
>  tools/iio/lsiio.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> index 98a0de0..c585440 100644
> --- a/tools/iio/lsiio.c
> +++ b/tools/iio/lsiio.c
> @@ -95,12 +95,7 @@ static int dump_one_trigger(const char *dev_dir_name)
>  static void dump_devices(void)
>  {
>  	const struct dirent *ent;
> -	int number, numstrlen;
> -
> -	FILE *nameFile;
>  	DIR *dp;
> -	char thisname[IIO_MAX_NAME_LENGTH];
> -	char *filename;
>  
>  	dp = opendir(iio_dir);
>  	if (dp == NULL) {
> 

