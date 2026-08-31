Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44AB2877E8;
	Mon, 31 Aug 2026 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788136056; cv=none; b=MwdFYIjUF67Smeq0z1sIE6wfpy1XfG2cg8RXlQGgSGLNGFIj6rG+Htsp0t4whZDp+4Txy2VC/gAuyfnCho4WlxOUJSCow60f7PqenS0mF7Z4BncV2D94R+yAs+3LRjIhNQIs0Qm7JFBtvluvoMmUF+Nb06SDkwV/+yNbLOmO7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788136056; c=relaxed/simple;
	bh=4F43whH2f0XvuPNS0HhL7clb0Q22fLEcfZuGJzgXYVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kXPU+0iOyDjd3JCMFLYI+QFgYf5aMi/Xh8urIkSKFf6Qc6QuABAeU44vz5byYP9IX230AkZGhDPAWCzHY47wemlIP3Bxk12VJAwBcJqbrr4DTBah/gTV9senmr6MCU5nIbJWY7uirOUpe6uXC2NSgWn9CI3coCLFryNEYwplldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUNI77OC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUNI77OC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374911F000E9;
	Mon, 31 Aug 2026 00:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788136055;
	bh=/3c8swGZPIjy9qm5uOVU9u4/3PwyRuvmy7Xq9trE48g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jUNI77OCbNGEjkQ7kz+f7dFtIc9Jda43v2/u+cDxJ1aQNSjK0XPUdoVHZyJBfPC3y
	 pgKZqy9WJUL2KBMI2kVCs3pFtW0kyam7UxpFxPCVpGxLFL8cvbpPy3WtR+sTYB4/wt
	 SKlURs19eokT/c2+0j9fAuwjIraTIAQBakitrfOtOJNVMlCJms/Uy4JJXoeQwqve80
	 l1ggvZw7rETMODDno/9q0Fr0H3rvGl2KD8OQMrwjtRIT2GC5jkMAkt4WZOLDJ5x/xv
	 MrKipHR60lfozs4P/Jz9m81/6XC6css03fli/7cVx0dCakuGzgjNShEFRj/MfUlWCY
	 mNo36YF5mWjqA==
Date: Mon, 31 Aug 2026 01:27:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yash Suthar <yashsuthar983@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, grondon@gmail.com, linusw@kernel.org,
 hexlabsecurity@proton.me, sakari.ailus@linux.intel.com,
 srinivas.pandruvada@linux.intel.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: accel: bmc150: use
 iio_push_to_buffers_with_ts()
Message-ID: <20260831012728.0261184b@jic23-huawei>
In-Reply-To: <ao_iV2xg-1Oc5Ttb@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
	<20260825085156.212042-4-yashsuthar983@gmail.com>
	<ao_iV2xg-1Oc5Ttb@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 10:08:07 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

Hi Andy,

> On Tue, Aug 25, 2026 at 02:21:56PM +0530, Yash Suthar wrote:
> > Replace deprecated iio_push_to_buffers_with_timestamp() with
> > iio_push_to_buffers_with_ts() to allow source size runtime checks.  
> 
> With this you might want to use IIO_DECLARE_DMA_BUFFER_WITH_TS() in the
> definition of the scan buffer.
> 
Why?  The structure used is: 
	struct {
 		__le16 channels[3];
 		aligned_s64 ts;
 	} scan __aligned(IIO_DMA_MINALIGN);

So given we never let things get enabled with just timestamp, the timestamp
and channels always end up in the places the structure describes.

Where that is the case, I much prefer this to the magic buffer with enough
elements of the channel type on the end.

Jonathan

