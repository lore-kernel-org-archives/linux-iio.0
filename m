Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5048DA95E;
	Mon, 30 Mar 2026 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892930; cv=none; b=Td+E4KcED2TqQSctqCyVAZvsmfCePQvZsXzfBJFybEpmq3mIRXp5NE/KgbqK75+LX8p1IbXT5ee12hb90IxR+4wfxmHlSl09ZJQeWBzityTOoBocPfot1ALGhFPMsI7b8Py3vXAhFuNsWyrkyj2D4cDYVIKog/Q4EDwH/rQgbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892930; c=relaxed/simple;
	bh=pk+MYEvE12X1p98DgxfNZMV5N7yQsbBPvarnSdU58M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGRc5/O+saxGjAFl2UtsVtFrZfj7f6TNz+PsFeBqqfTrrxJ9birXKO0gZwr1CcPxSHI0vmBS68flYhlnOmMY87E3hZI3rbPTGh8MvGFrXiF3Soj6KdW6cHq+eN6NKTe23K9w1wzSk0OzyY63U/3Nc73g3JVD5MVTnhigaoBC5Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1rKcL3E6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1rKcL3E6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8047BC4CEF7;
	Mon, 30 Mar 2026 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774892929;
	bh=pk+MYEvE12X1p98DgxfNZMV5N7yQsbBPvarnSdU58M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1rKcL3E6Jf7O9CdkvtblgAICL8X8zwKF9EMHRcSBS4E6YkhPtAvwQYuF3/Y8Y286v
	 iNWItOW0/ZYlCKrrMOnMMvpUJOCq7M0OLl/3TxpoyRTc2LJkqGzTB9BxJrMwaIgICi
	 MVQVFqkFbqTQQ2tYyb2SCgHTeDzUss5d93UWIYVI=
Date: Mon, 30 Mar 2026 19:48:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] staging: iio: adc: ad7816: redefine mode
 constants to start from 0
Message-ID: <2026033055-prototype-sponsor-eedd@gregkh>
References: <20260330174024.20712-1-mdmahmudulhasan1511@gmail.com>
 <20260330174024.20712-2-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330174024.20712-2-mdmahmudulhasan1511@gmail.com>

On Mon, Mar 30, 2026 at 11:40:21PM +0600, Md. Mahmudul Hasan Mabud wrote:
> ---
>  drivers/staging/iio/adc/ad7816.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 172acf135..5acfceb90 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -22,8 +22,8 @@
>  /*
>   * AD7816 config masks
>   */
> -#define AD7816_FULL			0x1
> -#define AD7816_PD			0x2
> +#define AD7816_FULL			0
> +#define AD7816_PD			1
>  #define AD7816_CS_MASK			0x7
>  #define AD7816_CS_MAX			0x4
>  
> -- 
> 2.34.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/process/submitting-patches.rst and resend
  it after adding that line.  Note, the line needs to be in the body of
  the email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
