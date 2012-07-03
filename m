Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54636 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2GCR1b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 3 Jul 2012 13:27:31 -0400
Message-ID: <4FF32B7D.40303@kernel.org>
Date: Tue, 03 Jul 2012 18:27:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: another typo in comment
References: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net> <1341096463-13789-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341096463-13789-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/30/2012 11:47 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
>  include/linux/iio/iio.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 2afbb6f..72f8851 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -220,7 +220,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>   *			unlike modifiers.
>   * @datasheet_name:	A name used in in-kernel mapping of channels. It should
>   *			correspond to the first name that the channel is referred
> - *			to by in the datasheet (e.g. IND), or the nearest
> + *			to in the datasheet (e.g. IND), or the nearest
Nope. The original is correct English. Referred to implies some sort of
transference, referred to by implies that this name is used.

There might be a better way of putting it, but it's not that uncommon a
usage.
>   *			possible compound name (e.g. IND-INC).
>   * @modified:		Does a modifier apply to this channel. What these are
>   *			depends on the channel type.  Modifier is set in
> 


