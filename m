Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898AC31F984
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774830; cv=pass; b=q4yAv0sHUBnHc1LhpKeghEEqTiqD7AYri+SD7cxd7aO5db9hoIv+YetoaTD14BJ5tNt6cEqOMZAZal0oaIjt7hpw7YLlZdlTi/DHspZFDwUOsXr0YCzwXJeOKOWLVrjnp3AKGgYqfGQz3s1FSUeUYnFsX7Xxd11jYm8GWd4F6NU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774830; c=relaxed/simple;
	bh=QQwEMw0MVh6sm8c6n1mzKfmuAGunbeouVXp27oOjqJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zcm8LGZhArd4rU1DpsV2vwFH6NKus1CBOBBqaFpHcK39z+WAD2zkh43F4qWfhbtKHdhEgN3ab3h7sEknDsm8o4Yns1Z77pHvkp80dhrbaSuyT5mCd6By8xcUOuzDf0cLLVWmMMoUP0ppw94YfszeSoX1RRTBk6IPtaXKjCSCwB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgrl8dEc; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgrl8dEc"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e4af975346so8922885ad.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 20:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791774829; cv=none;
        d=google.com; s=arc-20260327;
        b=dxs+5eDGqiwdec6KhZ22kErduLX6k2Oz5lsZm5FGm4TK8ZvupbYGZ758IMn1jYb0By
         aV42kaQJbOnY7gWfQ8Yh90pYMAUbOdV4xe0V/fFt7bqaL78b0LkDaO3C6oD+/gUZrEPT
         4VF4DkPYPoszDC0dcly29nyTeOzPdn32A2fkgpzwcOeBIoIfq+ARVFUZdbBDx02N69ZT
         yNnBDEkz2hlc8RTov09eNFixKcmL8jvwCwyA0+ThoJKKSsmRIGRYzgDnPEtLRIbOeQQq
         qxkQHxVQC8TcArrPq/vm4sd8txTaNgGzB4XunP0LSvKb1Xxm5ypWV/LVxVsRYxp7KBeu
         TE7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QQwEMw0MVh6sm8c6n1mzKfmuAGunbeouVXp27oOjqJk=;
        fh=UnwMjuD1e+00DFmvPng+9sDcTv7vg3V6eS7PdLewYY4=;
        b=fVbxpzOSDsMR32dhIecl277u93aSIgHKoMMFuKwIPNG9Af3qPDvDiGikpQN2fDUYVX
         wEhWf2rAQmynHTZoMomST0HgqNnxnexLY7BbNN20DwUKiIWiMXGSaBADMeJde4MiT36J
         P3biJZ4jjmL2YFqShb9mGxtq9+K8a6J+g2JPbxA6YDo+jPixgZiGC+XgzxOvYiMDWVwj
         aZOsJvJdv2n7oemOOon+8fr3fjUnSKinCfiJuWsTy/WRNGhWNHxRJwMCzo8eGvODWzQr
         bG3H6CCGKNQpNRZxMQ42T+a47CFKqsegWODYdYwgHYOhCvgaFZu8S26dCU8SDs6Jrh7r
         CdHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791774829; x=1792379629; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QQwEMw0MVh6sm8c6n1mzKfmuAGunbeouVXp27oOjqJk=;
        b=pgrl8dEcdZnUtlPll7bM221Y5818hZTjzHF1AEhpgSLyOOGH4fIbP+ptr/sfl3kWxO
         jdJibfy04v85SUVQPMW797O1ZkJro2XThFq7uBQaG9jbUVy6r5yKkE9oF5EplogmPSa4
         9ro3J20Jx+dCw108se0YxqV6Nlg/ddZ4BN/nDfTEQNIfoPp4cp8JZuv3Q8+s7yT/ZIA4
         NFUWxaozfsIJwIW/6oUcl+W9H1J+jFt5HlnrQbJyJZrtSLmj8nhjGM889oAkbsbUGLbr
         O3mQVSMDjy1VF4ogdybTxHo6TrDU6pS8J/Kj+O6BkrrNoD+ZxRpgcE4ckR2/4mpv/RA8
         QKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791774829; x=1792379629;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QQwEMw0MVh6sm8c6n1mzKfmuAGunbeouVXp27oOjqJk=;
        b=ov32DjC1UuJ1eJLCcxsaHH7OHGy5ogjAgAQ2Rn/2ZAeyFDxJEe/WFgxLJ0dr/dxPDC
         H070I3sjr+ih2Ew4uz/iGShwmDsp39n3uuTN8QjK9xM1A5IUTdD9u0tNdz6Li4+t/pW4
         bjP2dHhylKRlOIFpOSh+PkTCJ+xQKZ2f+Z1fZCGekIhVE251FUGxb9RgsqElDFjwIp1C
         o4EMCn43DhAwgyZFPfgsPnr5rz/im0kpysefFNmJoC0ffP+bZbRqI357poH1NO7fzCAe
         di96IpDC7Xs83w9djuUdEVvppoT7CWx7jRlFipSm+EgIkEIaqX5j0950RvAf2h6BDOpO
         EZhg==
X-Forwarded-Encrypted: i=1; AKwUvBy2Jqo5Q1S/ipVQW59Qf4bxngANxvHnSwtN06kud27zUwTudUTtx0W6vNO+lO18ehX01tkt1mFzZ/8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwpirT4hezx+GkCP7JXPH7OkVyLNCqTn8meOdF6LkghNZ/XNZH
	in8w6iXxfAuZhsOiB9YG1DtpD5CH9Ncg6oj/dtvE6/0zySBz1a4lvHWuwf3l8LPXKWjZzVx09Ij
	BH8mzsCO88RzxQfL8t8fC9uh4MlYFfUc=
X-Gm-Gg: AYBFou0G+ibJ43Bpriwm5IjcPP4vBukVIO6tnDGU6rsbnNLwXsl04aUB68hC5chAGZP
	VovI8hWwhyFl/yK0d6mv4cUDj7u/pIgSfiiUxLv0eS82xaVIqTqCuEn2JV8mxpFcd1dhdaL+G/Z
	wu5bwf1HeWsWHYiE9lQkcFQTm0uRL+0ueeYXauPT0dvZEisFDdtWhjWFWcpnBvitjGBsJ6MRvMO
	gGvrbrxA96FZALzAyvpC195LPZpWTNNJZvnFJoaY9Ft0V38HfpsKfLdcvG2yFvFKXkYqflDYq7p
	FPVlBHEFwNmj3qyzHTCyFebvL+/L7++xIVHLOVSDmk4Vw8hzfs0ysLfXQva4H8XaYPo9PP8WOxo
	ICufEQULb2mTIPh9agaHKndvu4gYGoFJxMn2XksqMPSJJR6QPSWrrQnZ1k/DEhY9zky8=
X-Received: by 2002:a17:902:e884:b0:2e8:3281:6464 with SMTP id
 d9443c01a7336-2e842cfe9f4mr73943905ad.32.1791774828856; Sun, 11 Oct 2026
 20:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051924.60456-1-jain.sm@gmail.com>
In-Reply-To: <20261011051924.60456-1-jain.sm@gmail.com>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 12 Oct 2026 10:13:37 +0700
X-Gm-Features: AclHuK9uqDFJoTllpeX_OzZxUzR1wDkehf0yZbXw9ZjHspovKBm68NjSPo7pxb8
Message-ID: <CAABR9nE6KqsMUXYGROsu3icF8oAVTQ8b07dc7gxYcucqoaVJrg@mail.gmail.com>
Subject: Re: [PATCH 0/2] iio: magnetometer: fix the register restore on resume
 in mmc35240 and mmc5633
To: Shashank Mohan Jain <jain.sm@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Shashank,

Thanks for finding this.

>
> The Fixes tags name the regcache commit, because that is where the
> behaviour changed: the drivers have used this order since their resume
> callbacks were added, and it worked until v7.2. Please tell me if you
> would rather have the driver commits there.
>

Cache-only mode has to be disabled before the sync, otherwise the
sync makes no sense. mmc35240 and mmc5633 have been misusing
the API since their resume callbacks were added, it only worked by accident.
86fc3483a4d6 and afc8e3ee8307 just catch this misuse.

So please point the Fixes tags at the commits that added the resume
callbacks, so the fixes get backported correctly. I've commented on
each patch.

Best regards,
Phuc
