Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E6C569F17
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888282; cv=none; b=Zq18ay4MJFSE1n7Gxtnxr41JlbGzdovOqZznVh4Dlkl7/xARe1goGrD4B3iwOIXeuAA5wFTCs8WHjgQkiPRJszi7vkcTlgxOa0qnzNo8uh6+94gm3X0MAK4LNXgSGe1oZa5YQ5Wi92N+seW4PEbJm9pphdzuto55jB8y4g7x4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888282; c=relaxed/simple;
	bh=767t6hUgUdxrKWf7f2A3xysTdQByDSk5Uj9b4Un6JX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R8xEKJwVro013AiBzHk2UCK/jKaLH6Ba+sHPiRHzvEECffa7NoarAAtDe1ktRpejiJwyo3CRlh4y8JurgVwSC2ON1GxnqIc6EXji8jORSlQHwZ07HOsau5FzpkHP1vI3igVexeThMjvg3+XlfpGs+Ca3O+n3tLOpF/v3b3jqPU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3nzLNNa; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3nzLNNa"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso5492476a12.3
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788888280; x=1789493080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n1HHJlfn2XcOV1TeOuj4SXDQlV5H5y36ip/NG6d64DA=;
        b=e3nzLNNaAECdEtPUNrK+ne74rRbOpME27l+zFwxxcvpVh17qbtNAM7N9K/5nVKIEL1
         2NmsPRJhtbo2tjesnSvewDaBrguhO+DAcf8vJvfCb8BG3j75qqEM+ZbSeQyQEd0YdTLT
         xIY7G1vFi7U0PhVPvd8Sb8vf9i71RyTOWw/FTsmIJqxfx8RcORkyAizrwIQGyhGp/8UT
         3L4dcJgIw7ifEzJEYY7a+dLdao+oXHRVlKQaQKttjKDuUAFm0IOzv3e/ZBz5LJtwk92t
         lZ2VbH7lvyCKY292F0j/vZZhMGadp6t8VYkqj9/nwimSksamewn2AX18q65cI9tOW4cz
         4D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788888280; x=1789493080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n1HHJlfn2XcOV1TeOuj4SXDQlV5H5y36ip/NG6d64DA=;
        b=li9QumLezJuxh4Du+XsWFcwov7mLWK5lLzprkmsuUjTUjGdwhuFXlodgRZxgofepvf
         3d+t9I2yzjxNHfchP/bL8caNBzqReQfBUKxFRl6iuvpiAernmwq1JCEE97vrN31E85tS
         zSCRJMBueRDUFY7fstC7gGINoVVAVUVsd/fi9Jh55NFaXYg9R6+GqqupnceGkacrTlSQ
         y8SEZs5c8BE8UF4aTeLLjWv3Eg5DabgE87M5zW3qwTUdeFzDtpuBL/NUaVdcg9H51eqg
         iaTWrakgQCiYjdSplCAHgqmPe7HV1SxKVMRkk8AfPaGFzykF5mJCALzZQYFCwZcwCN9D
         IDag==
X-Forwarded-Encrypted: i=1; AKwUvByXzhUz3y5L4au4JiSdLdeqvvApRXxSuvN+15dWdIjiDk5gslhIn3FIBfDLtXoKhmetzv2O9imWaI0=@vger.kernel.org
X-Gm-Message-State: AFuF++mSbLb8+/w6lWQLWHuFlmD9ixjiYD5K/FtLvb0PHzR2HmTMTVSK
	khhbTS57YZhVDDvhhBVYRplXWIyi/PtDLX6ckV0PoOOTU8bPUduhESaj
X-Gm-Gg: AYBFou3aogev6RfdD10098hPosgKE89LnI3fNdlAe434PvgekxXAbQbUgB9W40OytxK
	VFXw9nVnzkZ9X5Om+QoNezVMwltjXRKuO48mXGquFbmer3YYJqej2iVq1BO+WsqZEhjy+rhHtGE
	Xx6pOd+Da/4ls7wOAbV/rYiRJrhwsGPqcl/J2Wc6iqBIeWaz+/b0tn0N0qIYzYyC7QImXhT+ZrF
	MHH3t62EmTpwC0X1huw+TXqzeZDKp80tw6wY/oSEe7dNiJCmrrTHKZ+E2c/G1zyNu3pziBBa10k
	hOc9Pau7g1da5u2AQawAr59L14XRy2CDZK5vQyFoAxGmyhS9X9KE6t+aI871R4a1aBAzz2PlODS
	gVBjRRyjZrzgX4MCj9ZolY/ul0m2l/0XK26YNq45722wlTqwaW3JJJPYUIXLF1j6AY+YdgCTnMJ
	4w6X8tU5LE+2fR+J5Az663Bxficob28sUbjLQL4EgmEd00p8sT6z5YQ8ejSexQ
X-Received: by 2002:a05:6a21:6487:b0:3d2:2afa:d77 with SMTP id adf61e73a8af0-3da3a0b0a9amr44752599637.14.1788888279580;
        Tue, 08 Sep 2026 10:24:39 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:43ae:bf76:d99a:e5ff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33688cfc714sm19297176eec.20.2026.09.08.10.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 10:24:39 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v4 0/6] iio: adc: bcm_iproc_adc: convert to devm-managed APIs
Date: Tue,  8 Sep 2026 22:53:53 +0530
Message-ID: <20260908172359.30003-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Changes in v4:
- Move the ADC enable error-path cleanup simplification into the
  clock conversion patch.
- Simplify the ADC devm cleanup action.
- Restore the blank line after the copyright header.

---
Mohammad Shahid (6):
  iio: adc: bcm_iproc_adc: sort headers alphabetically
  iio: adc: bcm_iproc_adc: fix include dependencies
  iio: adc: bcm_iproc_adc: use devm-managed clock
  iio: adc: bcm_iproc_adc: use devm-managed ADC cleanup
  iio: adc: bcm_iproc_adc: use devm-managed mutex initialization
  iio: adc: bcm_iproc_adc: use devm-managed IIO device registration

 drivers/iio/adc/bcm_iproc_adc.c | 65 +++++++++++++--------------------
 1 file changed, 25 insertions(+), 40 deletions(-)

-- 
2.43.0

