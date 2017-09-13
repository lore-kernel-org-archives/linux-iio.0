Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdIMRDO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 13 Sep 2017 13:03:14 -0400
Date: Wed, 13 Sep 2017 18:03:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshi Jain <himshijain.hj@gmail.com>
Cc: outreachy-kernel@googlegroups.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nick.desaulniers@gmail.com, daniel.baluta@gmail.com
Subject: Re: [PATCH v2 1/2] include: linux: sysfs: Add __ATTR_NAMED macro
Message-ID: <20170913180310.27cbf1b1@archlinux>
In-Reply-To: <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505291907.git.himshijain.hj@gmail.com>
References: <cover.1505291907.git.himshijain.hj@gmail.com>
        <2bc7a124ab925dd2c50aa8c778745d179777d50d.1505291907.git.himshijain.hj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 13 Sep 2017 14:14:07 +0530
Himanshi Jain <himshijain.hj@gmail.com> wrote:

> Add __ATTR_NAMED macro similar to __ATTR but taking name as a
> string instead of implicit conversion of argument to string using
> the macro _stringify(_name).
> 
> Signed-off-by: Himanshi Jain <himshijain.hj@gmail.com>
> ---
>  include/linux/sysfs.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index aa02c32..20321cf 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -104,6 +104,13 @@ struct attribute_group {
>  	.store	= _store,						\
>  }
>  
> +#define __ATTR_NAMED(_name, _mode, _show, _store) {			\

I'm not sure about the naming here.  The normal __ATTR macro is also
'named'.  Maybe something as awful as

__ATTR_STRING_NAME ? 

Greg what do you think?

This is all to allow us to have names with operators in them without
checkpatch complaining about them... A worthwhile aim just to stop
more people wasting time trying to 'fix' those cases by adding spaces.

Jonathan

> +	.attr = {.name = _name,						\
> +		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
> +	.show = _show,							\
> +	.store = _store,						\
> +}
> +
>  #define __ATTR_PREALLOC(_name, _mode, _show, _store) {			\
>  	.attr = {.name = __stringify(_name),				\
>  		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode) },\

