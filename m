Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993537;
	b=zgFvzPMUSlRuVol2do7l5ODYYzwP4+D3eR1BKQZY/5RSR947+crZFQN4N7PerAAy6ZrS
	 gkWMumXOK2RBe0CstJu8Ia5HFJMZ/9Ckha5G3myLcekXsn60v9CNTU38pLDxx0M1aryHw
	 MjlMEYBvd1fXTN/BZkOf6SqK03Y3IlbixWg4n8Bxm+dQvPtdWnwFoakNI6i5CRcVMFcqB
	 4eA/DXOCLq/oWYicIUlfSmnfLaivzcJ4b62fbFTiYt38qtg5tNPFOM1NLrFn6A2FJuOdv
	 HVWhz0KWzK3m44z3/qGJLQXutTT5Dd2kzI/NLUqUig8l9UCk5k6ETy8zTEj89d/BriA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993537;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=473crE0SSGdE25OE/ZhuZNLv2HWb2HSt1DmR/h4oQgU=;
	b=V4HJVAhRxs//uwy9JI4QN8SKv4CIRgMv6vyGhsJRQph+VLzZLujjAQ2lPK61QqTg/uv3
	 /3gSxQtxUyB98HpoILMYO71ukVSqz5veIKP8LolYW4k2D/B/LvSRjFJWgqW7TYkHBNf+3
	 0LqGa/pW7CaDNmACo3QpIP8IfgUgHXzAjMzQqA8Arapyw6f+Bi4g9jDJcDYNnkkFhp9qL
	 jjw1+aExM495sLsIwcL72xiVRK+25KzHrUvGNECKuEYqrobjlzMBJ1eg4jke75gwuSj0j
	 dwIp7o8T1hJyBaZBa/YFFDT62vDqYpEjSk4liAG2/zuPUgGG87UwDgRfEMrSHTR3x4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFTsCOI4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7D606A326;
	Fri,  6 Nov 2026 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iFTsCOI4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE53D1F0089F;
	Fri,  6 Nov 2026 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793993537;
	bh=473crE0SSGdE25OE/ZhuZNLv2HWb2HSt1DmR/h4oQgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iFTsCOI4oI1zkZNrVA8LjHza+UVYi6S7tdHT3B0oZiNyUC9EnIZg3H9jtS3N5DXKB
	 VrjW1eRSqzNpLb/edNPgzKeTNcJ9TljYFmWZsL8NTyAZJByiFR0oQvpsbv6qtRqJlO
	 G4SvuNU7RNHlY94j6vBFGGTvFa6c4MJHariBSV3gP3U5s77YifMVPInzpVFJ8DQWhN
	 CTXte7G70bCVMJ0YYHoDfBevxvDM5DMvmAVftVWTMeBQzlD1+G0wR55VPQCJcjY7sE
	 OWN5M28QAcGG+pzSHqGi08+1tT6m4Ay4SRXhV1ALW0wObbkJ9LzJokV9SLFGeI3dRg
	 kE1+DyfXkeDKg==
From: William Breathitt Gray <wbg@kernel.org>
To: phucduc.bui@gmail.com
Cc: William Breathitt Gray <wbg@kernel.org>,
	andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m32285159@gmail.com,
	nuno.sa@analog.com,
	sozdayvek@gmail.com
Subject: Re: [PATCH v3] counter: ti-eqep: use devm for runtime PM to
Date: Fri,  6 Nov 2026 14:32:07 -0500
Message-ID: <20261106193208.4136410-1-wbg@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102100031.5573-1-phucduc.bui@gmail.com>
References: <20261102100031.5573-1-phucduc.bui@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=707; i=wbg@kernel.org; h=from:subject; bh=3e2hmBvwAtTabO9HdSERGS+iq1d9dFwYIQ8s6fwBlQg=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFnvtBV1s+dZnM9KXO0VpSP78r3uNL6uuXsWaE/vmRnzz Y493i2no5SFQYyLQVZMkaXX/OzdB5dUNX68mL8NZg4rE8gQBi5OAZjILA6GvwKH/YVfpQSe5uGv u+9Yrn9GcL+TYtrkkOx2lwPT/9idaGP4Z3+EW+Hamg3WtZyiX68tn2G05R5r647ZPP1z7jlMuSl 3hgsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Mon, Nov 02, 2026 at 05:00:31PM +0700, phucduc.bui@gmail.com wrote:
> Hi Stepan,
> 
> William pointed me to this thread after I sent a similar patch. It
> looks like there has been no v4 since May. Are you still planning to
> send one? If not, I'm happy to pick it up, keeping you as the author,
> and address the comments from Andy and William.
> 
> Best regards,
> Phuc

Hi Phuc,

Go ahead and submit a v4 addressing the comments from Andy. Submit a
follow-up patch as well to eliminate the ti_eqep_remove() callback as
described in my earlier comment[^1] in this thread.

Thanks,

William Breathitt Gray

[^1]: https://lore.kernel.org/all/20260604021902.891327-1-wbg@kernel.org/
