Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756988;
	b=bO+6UP5RBwvziUAxBK7W4REgYFH/fBKRVicztdWa9D+/CEucqhz+oNE49YfwJ3Dsgh3x
	 0LCFFOaWURWVxVDZMkPgJv77dq1/BU/BVehGbFYkdt4KrVbn5FQA4ucxLYKD4mfsM5R3u
	 TpB4fGzaYqZQXA9EhVcncK8McwI1FAnRIqjwl0RjeHV/J0kPdhkH0xDTGQnAlqw1Rb8H4
	 3NuEA6nAVA4aeSndoRg433bcBAVF8NseuLJKHroP2f+R/YIDzf3tz/qDfZ4e8midRl6tL
	 fsLTnTedAPIu47WTB2qPQQjSuovd41Vtzq9osNJgOkdZ1l+ucSCIvx/jn3Z/7lz7Z0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756988;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x2y/jrRuW1kOVkeI/kyVA0jAKmFvPNzDOon3GN/uQPs=;
	b=jzZwcwW8xPWHAaTte5Xaf0/7Om/olMwVJ+Adani6cpWHfb5pcQHBpMTSPG8bfUxlk0hB
	 /Ceik9PBtvKriDGiS5DoQqhiyeaIXuykHqAhsicoJw4SS8z4WNQcedHSmDpGakVjZiPxD
	 MmAWeXtODMcRGwLn/AV3LAA0LrlNLrvSjJ8h56fzfbIma4+lT+seParBcYpEACTlILZek
	 vFh5JEtL1LbX0JbKpRa0KIX+EgEsy1WC5HfzdkhAQCE+Xvn3ipajXBw+sJsYTQSweS9h2
	 N7oRBYE9OJcwR1V7NJ81VsRfHGye6cwyoxsAL5ufm1HArGWHuGvV766HibJArdpKG5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmwWK6LW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807C1606A326;
	Wed,  4 Nov 2026 01:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OmwWK6LW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6F51F000C1;
	Wed,  4 Nov 2026 01:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793756988;
	bh=x2y/jrRuW1kOVkeI/kyVA0jAKmFvPNzDOon3GN/uQPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OmwWK6LWBHsuAIc4CYoOo4VUNuEAq0PQhJmAv7o+GvrlV5bzf986F8gS2Sab+y2ak
	 xlR1BPQ1Jv6VBdQ+bXTlY90xFEk9UWsSm3jo2B6AeGiwn5t7OBAHyF9JN2xXGNTMnI
	 yLDIR9UQkeg1t0V9BAnwBMCLpZajvT0Da9uqCzSREaPgsL2m45nQ9mL5X3GkfPNQ1q
	 c3B88X8x9zAwOVf0Dlt28RjnQHpYvBxGyueX93U8kcg2Yso6pfX7Wl/QQXrFHxhne3
	 r6jWAD+UuNtiiyAhllQQkIEoWDHlhDdc2VCiiW9EFXTv5yfpJFAF4mY05eBIGk9epR
	 J1mQ/X/+5KJSw==
Date: Wed, 4 Nov 2026 01:49:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: Fix runtime PM refcount leak
 in trigger enable path
Message-ID: <20261104014940.565b8fb0@jic23-hlaptop>
In-Reply-To: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
References: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 17:20:00 +0800
Xiangwu Lai <laixiangwu@cmss.chinamobile.com> wrote:

> From: laixiangwu <laixiangwu@cmss.chinamobile.com>
> 
> Hi Jonathan,
> 
> This is a repost of the v2 series as a new top-level thread, as
> requested. There are no code changes since v2.
> 
> For context, this series fixes a runtime PM refcount leak in the
> mpu3050 data ready trigger enable path: patch 1 splits the enable
> and disable paths out of mpu3050_drdy_trigger_set_state() into
> separate helpers, and patch 2 applies the fix on top, using
> pm_runtime_resume_and_get() instead of pm_runtime_get_sync(), which
> also keeps the usage counter balanced when the resume fails.
> 
> Changes in v3:
> - no code changes, the series is reposted as a new top-level thread
>   (v2 was mistakenly sent as a reply to the review comments).
Future reference. Don't do that unless specifically asked to do
so. Obviously you should never be in that position again, so this
is mostly for anyone else who sees your patch!

Thanks,

Jonathan

