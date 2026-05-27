Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC7A3859FC;
	Wed, 27 May 2026 07:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779865337; cv=none; b=Vf28Mnca1dwvAj0O7gKXsagCfxLDmSwduNqntWAeHBqQXb0rlUd9+mLqmysL9wJqvLjY+1n+Zpi+q3o8p90/17RP97NTBkep8MzwzNtdR5gSMLS9jMtC+7QvfuCfR+uhZ7m2C6ancMXEu8gH1zhIstZxEwTGkcMlyc899+KOetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779865337; c=relaxed/simple;
	bh=2II9vm/59edoijDRqUUqnmg3fWp1Cw3PTVbucHXjqDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0tJ9wPM6k+lrg7E7Gr0xDWBey2GBE+RkZXU4aO1tToMGzw19kqrX3qq1ZF9FioeKITvos6RDaB8u4t+Zn9xUwq8MMvUUta1lMU6Y20y77rbI1O27Xr2i2IGMvJMOxmH/7fnadIIC0n5c/xWgkOjZoGpyk8WtbY8qBDWJqxTF2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jru6ARm2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jru6ARm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C311E1F000E9;
	Wed, 27 May 2026 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779865336;
	bh=OCL1bC3cQatvjl5IDNunios1yI5OWnaqrhZZQKzV4sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jru6ARm2ybB7dlQ57MI7BsS+TqXbc3C4HXQGYrhI/zu484QIzKE5V9AymvIPszL2s
	 C+X7hp2lP6G4tQ3aUoVHou0RUYBeaOGFLVpha4uDlTbYAjY7Vx0Tb/DFi+flmCxIlH
	 3KCKh7ImKHK7TQ4ZcjHleUDi7ZQYlqSeAH1ZjxESYPD9jRLVMukePh9K0+Kx6ML4BL
	 hK+2z9l5Y71AFr1hefn10Opp5Rf3+V23T8DfL8dzwo6INevFXwV7mXNEl+mmcsqn2b
	 uTj9YtBSN58Rku40yQLKnXwNcmRLMYEv2qTacvGDQ95QwnPYlilOyP3c9HXNufFwQg
	 fd4tyjGSO99Rg==
From: William Breathitt Gray <wbg@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	patrick.havelange@essensium.com,
	peng.fan@nxp.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org
Subject: Re: [PATCH v2] counter: ftm-quaddec: use devm_mutex_init()
Date: Wed, 27 May 2026 16:02:10 +0900
Message-ID: <177986528627.502937.17837579399863553135.b4-ty@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525151240.7258-1-sozdayvek@gmail.com>
References: <20260525151240.7258-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=580; i=wbg@kernel.org; h=from:subject:message-id; bh=HPDHz2buRIlz0e+RlNv5VLc0oVgu7KOAl9Odi1+NRKI=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFli0+6LLQqY2XjKquZ/dPQroZSdM5qfJVpsuMHz/unNf stNDdHpHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBEPqsxMnxK2G1k8niLVnHJ zqR/x08buuya0JEd+/3wuyzjg79z+lIZGTrUJ2pu7nf16bisJHPgfMiHcr+IVX8cinP/hYndeT8 zgBsA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Mon, 25 May 2026 20:12:40 +0500, Stepan Ionichev wrote:
> ftm_quaddec_probe() calls mutex_init() but neither the cleanup
> action nor a remove callback issues a matching mutex_destroy(),
> which leaks the lock debug state when CONFIG_DEBUG_MUTEXES is
> enabled.
> 
> Switch to devm_mutex_init() so the mutex is torn down in the same
> devm scope it was set up in.
> 
> [...]

Applied, thanks!

[1/1] counter: ftm-quaddec: use devm_mutex_init()
      commit: f981309937538ca7425fbf65fe4c339c00e50eca

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>
