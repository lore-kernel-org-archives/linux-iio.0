Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73448BD20;
	Fri, 15 May 2026 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857880; cv=none; b=O5ImVOJ+7axmDEfz1QfSld99L5ze+7o7m7fQjSzPX9oODIprYA/Gnhy+27Yz5eA2/7GpO6KsVO3+mvnstl3bW3PD2yEnrGGv6Zh8BkFEqXubv3+bewCLKkt2P+bebn1W0q9IM56F+o4s76TrqSexGj27HadUBGMJmEYzNfrfZR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857880; c=relaxed/simple;
	bh=udpQOsmVf8W++m4QYGtO4L8zJV59RAnxZm0ds3ogvGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2kmphsFD1ayp37QqVa2dfkRLKXUkb55tgBhI26WYApvOBLWRdmfKwEf6TSe1cJ3m6tpTYOjmuLc6eCj9vk85QKvSrnanbGjf9GUdSsF/LdYjwcKLZ5Fu4lf8/l8EZjPyioakBu3XQ1ehP9xyir5Tdk53/rK94jJzRCSvqRWXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0mKOIlZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0mKOIlZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45A8C2BCFA;
	Fri, 15 May 2026 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857880;
	bh=udpQOsmVf8W++m4QYGtO4L8zJV59RAnxZm0ds3ogvGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0mKOIlZHKmFn9GLgwBbBwEOd6b1cjtllSwDBVBFrvIR+/mPHSldZ68tTmmhXoNmj
	 +T6/dcS3XlY4jYsvPb8BRbJN7eYMLrenn3LPnRfq8AwiJPjk8nwJvoQvm2PgTxU9dl
	 F4iXgzt5PQetkg7bxwuEygsIUWylOzmLTMmuSwo8W434ic4NcfKhOr2RGrShavg48D
	 UsEf0LI1MGyDLUZZ2LBGPNh40OvEpkmM4sGGRT2GRaW0jmuXd9mzsE3V2sP+WH0F5w
	 OQH21OxHbcKyPskILrFhC5vA2igw6fexUpS1YdkCqbE1FVHKW1dqdI5IGrFuEtsra0
	 KPsDVvkP3M24A==
Date: Fri, 15 May 2026 16:11:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 0/5] devm conversion, wait time, locking cleanup
Message-ID: <20260515161112.4877f725@jic23-huawei>
In-Reply-To: <20260512223215.25596-1-aldocontelk@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 00:32:10 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

General comment. Cover letters provide the titles for email thread,
patchwork and sashiko entries.  Make sure they have same prefix as
patches.
iio: tcs3472: ...


