Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35716 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628AbbFAVQp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:45 -0400
Message-ID: <556B36EF.6040800@kernel.org>
Date: Sun, 31 May 2015 17:29:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 06/32] tools:iio:generic_buffer: add check before free
References: <cover.1433072539.git.knaack.h@gmx.de> <a25039ed5112dd904b888d2697df4e8760dcf47d.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <a25039ed5112dd904b888d2697df4e8760dcf47d.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> The string trigger_name only gets dynamically allocated, if
> !notrigger == true. Therefore add this check before freeing the string.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Under the notrigger condition, trigger_name is null and free is a noop
on a NULL pointer.  Could be argued that it is more logical not to free
it though!




> ---
>  tools/iio/generic_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 0410948..51ae3df 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -358,7 +358,7 @@ error_free_channels:
>  	}
>  	free(channels);
>  error_free_triggername:
> -	if (datardytrigger)
> +	if (datardytrigger && !notrigger)
>  		free(trigger_name);
>  error_free_dev_dir_name:
>  	free(dev_dir_name);
> 

