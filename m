Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794167800;
	b=10lbMf12EaSEC5rJXqinVt/huOJ7NggSzpHYgSoRWmRfrbZSpErpJSVUJZhj4NcgXl1J
	 udUNH5aeQ0uZnF3n1Z0ek8tQi5HtAPtdRbsLEHVfcEQWO2UjLvzyY148BpnJFuLn5tdu1
	 C0DEjV4GRh1CsTjua/g7jsYIxHit7ianMMSYfH15gGTWoJ2I35SnAaR0w+E6b6m99/gy6
	 fOcVrxqmjnNMqhLIpiPWhksj5Qk/BbE79dorL4kOYEc0kr2gTpdcM+t3UnAvwvgocj5qA
	 rBVdm7gD7ehmoHU2j12CQ1PIXlmwIeWHKNboHf0tLeLvng2DzIdU6+gmXNWaHBeDmeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794167800;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3rZYj1B4aHE0LcvfJWEAzcBVgDYUiJ3fHXrQ75KN+sU=;
	b=2KG67S59pDM3FOG4Kgp1SeEz05pDz77f3OEQOMHvCVY+IWWiLvSG5x+LXP9quVV2z4nG
	 SIZI0eqUkLUlPH06Rz0fsIzQjSHx3v3VEFkBcE69OJa6LLmThVqYGxVmO22hR8G1CYYiq
	 vM/vr0a53onXlKv4sk1ECI2ziz0A9jvUAnum3iByaPLEgkGkbd5333Q2s0De/xfLczcjz
	 3hLHMVh6Q0siFX5K+uXmxQUbRNrnLmQkNxgG7De5GQO7EGWwRh9kebeW9a3cIK7Q+GFJu
	 gcmUxopYEgS7CL4bBBwM68WLd/28siS/oWeiLDzF9dNEUynhZYosXPj569OuS5OZwug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZHAReQ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A82606A326
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 19:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZHAReQ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD191F008A1;
	Sun,  8 Nov 2026 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794167800;
	bh=3rZYj1B4aHE0LcvfJWEAzcBVgDYUiJ3fHXrQ75KN+sU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bZHAReQ1daxdjulAYvzo8c+P+0izhwSpmjWKlP5uNxWdabHpx+TtnFz/5GqeKvk24
	 l7wEFTJu+pyt/00uyqynYhu94N+imqhCqIE4OlVW7KtO4wQO4km1MSUYugqU2wln/5
	 lGU0sxZNbzFjrghYqtWSIy9POihG7mGXQbEkiqX7K2/5bnHV+iOJJrknf3+IsjAtzp
	 A+9n0mZL3pLb0H1EWWmFrFbxGk2XVvzxPooOTQqjXxwBP830aG5y8kHRzjUuvSHFwL
	 MoN2f45hL6/M5Ep3QzWXsan/3HO2iCIfKzwnxNM29ool9LAKZBeZJYqj7saTOe0FBL
	 JpvRAipilU1HQ==
Date: Sun, 8 Nov 2026 19:56:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jyoti Bhayana
 <jbhayana@google.com>
Subject: Re: [PATCH 20/39] iio: common: scmi_sensors: use
 iio_push_to_buffers_with_ts()
Message-ID: <20261108195633.53a4cc74@jic23-hlaptop>
In-Reply-To: <20261026-iio-v1-20-8b136778eedf@oss.qualcomm.com>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
	<20261026-iio-v1-20-8b136778eedf@oss.qualcomm.com>
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

On Mon, 26 Oct 2026 16:05:38 -0700
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> wrote:

> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> Replace the manually sized iio_buf array with
> IIO_DECLARE_BUFFER_WITH_TS() so that the timestamp space and
> alignment are handled consistently with other drivers.
> 
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> ---
> Cc:  Jyoti Bhayana <jbhayana@google.com>
Applied,

