Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5666392C29;
	Fri, 27 Mar 2026 20:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642277; cv=none; b=FQBM/GYEwHSWYS3UBOxG2HWvC0LWSmvS73OuuVPr5DmtJVmLzSJ5WrSVIOgrpPDDmxhBQLZtab7cJP+XrQt/7xxrXfVzWUUE6XCnogwdLKLvRQPa9oLqak3nE8K4xA2RX944+Yl70iJ9R5hUhszM8Io7b+6/Rb3UYMw8ULa4DJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642277; c=relaxed/simple;
	bh=cGtXYFRbYbC87SQmY2jJTrdM5OGWc7E8qTfb7IcmZIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJTuZvMEFeSQqr1c7lgTOb66K7D98zvtB2TRQ1IkkNcU5VXdDKZ8lACQdG10VYZ0wf8i7Vdy5xy1uez6tQiAtDHCF/Qgl22FWQy6lH9U8QzPhG08Yfma8xNvHkoj4aJR9A5+UIn8iPJ9LEZxEjFUQglIooSUeCLR0KSWfcDiiag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EgdMFSO4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EgdMFSO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3557C2BC9E;
	Fri, 27 Mar 2026 20:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774642277;
	bh=cGtXYFRbYbC87SQmY2jJTrdM5OGWc7E8qTfb7IcmZIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgdMFSO4nm5lo3+qR6TlgTmopDpJd3aYQKOUNXMA83YutTwPSxuZui6ppcquj0ywQ
	 dQHrmWBnyZAtCMkq6L///SRFIvAg2ble4ESK+cGMTZd/T0Qg+n3uPNk8Ml4cUBiNFb
	 bJprQ6arQysP0pv0/rc4Xm/DGt7oaYjobLAr2xCM=
Date: Fri, 27 Mar 2026 21:10:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: yugmerabtene <contact@yug.be>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 0/3] staging: iio: convert sprintf to sysfs_emit
Message-ID: <2026032734-mango-unshaved-17e5@gregkh>
References: <9ebdc790-6756-476e-9c65-63f32b8bdab2@yug.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ebdc790-6756-476e-9c65-63f32b8bdab2@yug.be>

On Fri, Mar 27, 2026 at 01:00:45PM +0000, yugmerabtene wrote:
> This series converts sprintf() to sysfs_emit() in staging IIO drivers (ad7816, ad9834, ad5933) to follow kernel sysfs API best practices. All changes are non-functional.




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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
