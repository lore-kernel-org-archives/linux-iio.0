Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793503948;
	b=eD5p8UoDYSPkXxMinBskVw1u1RMH4lLy/W7+Ah6dvJnP6rhUMV6KQ88l8Y//f37Xb7om
	 tQ+QqsJRM8oRzYY01RwzVFhL1XCSKaJJ6yxtZRXeUnfq/eHEweq29ddoXLYbgtvZhrKHl
	 gNeI9ul7dMWYFzl2swnKoCexHlxBI19qUejDY7HDDqUFM+ulM6yDdWwSqGgF87apE/oO3
	 Jy69MQi8yprffbJ5DJxUuipzmFCsZOeey7jt9maxfS/hlRm+esQf5wOFPmJcSh3Lxi8Iq
	 vkHhs9bqp+l3vkzyfPqSTGxjaPJWTiYAdISGQErdHFxVfiGlpYqQ4HbiMT4LgRvA1xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793503948;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D9kj5Dm9+ryU73BM0Hu1CqoHmwpHuXGCrVhVWrv+Z24=;
	b=weiySbXeKfKyJNRRfNZMn7s5gSiZuElD2QIa3wSPgi1q7gJd3UX+TGb3eL8EaI/Mal/p
	 QyVC9EQdiQh8QoBFOJ201Up1/WawUj+GHs1nM0zHegVdrKQNGX3l5KkgvvhWEq4kvHgFZ
	 ShCKfUgRiMEPpsFSF5kI7L4KtSpThFXRKhASQKfxLhzrjFc6d+hToiOlZb0GEUJQ2CLZM
	 aW2+Av3aQw2Fne7sHJxrUhI8DkufSGtsLe3/geZUwBsq3gYME4eHbrNm+wZb0mgGAfzwR
	 j0HnopctjcY2QtnYrcagBMYTzeqZLwb7ewOTh3mp5wJEZVuF0Nax1bTbJj/YGi9NzbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr8i4UKs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B522606A324;
	Sun,  1 Nov 2026 03:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gr8i4UKs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD051F00919;
	Sun,  1 Nov 2026 03:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793503947;
	bh=D9kj5Dm9+ryU73BM0Hu1CqoHmwpHuXGCrVhVWrv+Z24=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gr8i4UKsYE4YTOkaq/SIu3w3gh61/AwmmGJP3zYi/Map3n9Sy2t1CUkvq9OS8vUvF
	 eGp9vos2tj8xvdzvaNQ+6ZIGf73PuxDb4+oo3MBAxR6kBM5CwIfqmf16paithlU6gc
	 SZ81pR454Sv0Pz5QiRDpsWMkzJt0ac4822/Nrzvc2B81YdV9GVrw4nbgDkwfRwIy+s
	 0LQGLeFsIuiB97ViK1uSe4lMr6+bDGzU5NgaQaD3+tiOUw+2wCIQk2uughetD4+PRJ
	 bNtNwdDcSiSHy6grFrSPrrQ6XK6kkqLqGsxbz00DnfnJcvBTpGPo74NFIGgujtZwB/
	 FoZZPU2ON/giA==
Date: Sun, 1 Nov 2026 03:32:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] iio: update email for Joshua Crofts
Message-ID: <20261101033220.1e966e0d@jic23-hlaptop>
In-Reply-To: <20261027124602.1533-1-crofts@kernel.org>
References: <20261027124602.1533-1-crofts@kernel.org>
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

On Tue, 27 Oct 2026 12:46:02 +0000
Joshua Crofts <crofts@kernel.org> wrote:

> I'd like to use my kernel.org email going forward.
> 
> Signed-off-by: Joshua Crofts <crofts@kernel.org>
Applied.

