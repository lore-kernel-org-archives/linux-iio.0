Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9148F3F20F4;
	Mon, 18 May 2026 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118420; cv=none; b=GnUoIeldQBHQ5EvTqRUHviWhMhDQQDATJLkkFqjqROtOl7wji1oCzQOXYAQll80LMzpugvZg3TiErmDyCdcAvkJRPmkxm8a2o0iJPkSxVhPYcLJ5dHRDZpk0dSPKZkURQ2nB9VKEXEkweWFIFLiEkfaTOILUESU5FcwM0FBZooM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118420; c=relaxed/simple;
	bh=CfWMG6psagp1xgL5UHU3ENB/RiiCdo7XkEz+/lgOJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moFVIaf+V640r2zVOslkL1Yt07Xpa4/z5449F9yl/6F58ua/ugPhlkMNHIP5TgfenkalysYn2K2Dwug64Bw3d2cG1CobyLTGG5g9dfpgF7DSc9dtZY+Wug7E/TSwMp6Z0b54xkV/HWTpNlJ2xpMAdmWrBInS7ciy4Fl2EEN1nvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8Fq7vGS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8Fq7vGS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711EFC2BCB7;
	Mon, 18 May 2026 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779118419;
	bh=CfWMG6psagp1xgL5UHU3ENB/RiiCdo7XkEz+/lgOJ1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V8Fq7vGSTeDcuBOlj3+EQGgkQpnV/eBd6dKsBGUluCJ0Tqb/qFycHX+A21ZFQtsrS
	 BdTHbRXy7kcjkn0QOnbhFsTwtyy4kg9SwftN2I6EMrXSaRlcPuK0g4FtXmBM/Q4XIr
	 wrNYpPBzI0S/MKB1b5c0l4eWkNFQQlShErvFx+84Y7qLP0xJwUAOTowR3cmQrW3fB9
	 KSn7/qJwmb3QnPj9voGT+M71q2CFsiNxpkSyB/5TbMtI0I52c65r4GbDDbYDDTzDcH
	 NaRaP+xTv/BjCMbH6f6dOJBNstiq24wpRYwVKQ36CjNFdhu7XGwL3LgUYHWQOUpa0T
	 Y5XH0AzEYKsPA==
Date: Mon, 18 May 2026 16:33:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/2] docs: iio: update dated triggered buffer example
Message-ID: <20260518163331.2ba650eb@jic23-huawei>
In-Reply-To: <20260517-iio-doc-triggered-buffer-update-helpers-v1-0-7f00d4188f6f@baylibre.com>
References: <20260517-iio-doc-triggered-buffer-update-helpers-v1-0-7f00d4188f6f@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 12:00:57 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Noticed this example was out of date while grepping for something else.
> And when I did get_maintainer.pl on it, it didn't match the IIO
> subsystem, so we get a bonus patch to fix that too.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       MAINTAINERS: add match for IIO API docs
Well I suppose we 'should' maintain those :)

>       docs: iio: triggered-buffers: use new helpers in example
Series applied.

Thanks,

Jonathan

> 
>  Documentation/driver-api/iio/triggered-buffers.rst | 8 ++++----
>  MAINTAINERS                                        | 1 +
>  2 files changed, 5 insertions(+), 4 deletions(-)
> ---
> base-commit: 8678fb54958893818ddeccd05fea560a4e1fc759
> change-id: 20260517-iio-doc-triggered-buffer-update-helpers-ef7e3895c9f4
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

