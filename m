Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0D371063
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277296; cv=none; b=tH+GozXkYyJYLGMXee6lknwfoaWHXp3Df59/IeQ4ys0LBwfL1Pnijs8gwjmYfoYD5WvEr6h3HLO3CQTn52c8Qppm2BnhzRBIgrS0QwueEi07owZaj/bLP01bUfdbHMBDrJuVgt6y0S6ziXvnH9SSHqriy/Qxv8WES25UcnULU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277296; c=relaxed/simple;
	bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MLjfbELUjEDbHkHuHubdIgGYDceuxSnKH1xOdciWNXu/3BZ3jA9GhkUFUsq3LwvUmBZ56d1v7tBAr1djjLdRzO4tRZu/DcL2nf2w980KPzT9qAguQuFeRdS1ZDOSYFtMzRCUCGUMy/IvZlgLQMWq94Ccq5QYG+jhQd64i3jvTZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4kdo4+O; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4kdo4+O"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3939eab114eso6841261fa.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779277294; x=1779882094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=M4kdo4+OLBcBJvwVV83orQrAWEPWXJdteKdj1afu8dK+Nt7swzh6JNQSIRWJpHXNEh
         D26ka4UL04Z4+p6Oa20JMoSYsOjJlpkFPVqZtsAaYCL0pg1QG59yhXbtJExnRm9ZOLs7
         4w6yGCivdV44eAeZj6y8ZoKnaWP76TAVL6Q3fxEBJe/Jxs0NVw5X25Y6Xf6/GIgNztHK
         RiMKImCElIKreIsgTAgwSmvmyIKTNKnE09yUOS3W2UkP58veURwcOpZC2gaVlSSkuV/P
         0lYYYeW5N1g0Spdr4v6g1d6c6vul9tKcYTxA8Se/cDZ7lUd5ESDq0UPcsAZ8CDj3luMk
         Vnkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779277294; x=1779882094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAuvyYudARAkHTzjpNfFTMQwQ0je0Xwjq+y2av6CwfA=;
        b=YjlaBMWfvng0q0rvkN2LDqKmyPTww4YZpR5/4PO+sr0xyTb58/o3hqbEyvWCVueRJC
         1lqfPZvm9qf4movUk2cvwTrMeC3OOLMr4Y3ZfJdZR5w0axt89E1Mv7XfM4LpvH3Yc5tm
         OvJK+tr+9WI8+MP11+B3QXk4SjVKN6+Cqabt5tDQIKNOKHCeFMa8gs6+R469vpgksWpu
         8/GN0yYUETPoVMyYh7B7ud/3P1eVPJan85Z7QJC11A9zMU3QxdQ9GYuJ4o5klEgPoWTt
         dedFrJrGSHHK1L/Un+bLHX0VCfSsx9uFW6vrpRrEuEPSGCh28E9jKpuphkKX/QAuTkAo
         QRWA==
X-Forwarded-Encrypted: i=1; AFNElJ/7OzjGrQKMxHTpDRg1VeiaADh8tjFCCM8msPFpKUEJjGrjy0XAP5G3smfWzyBxFWGOAaX4Tg0WCco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEBQvSEnpSP4Q5pnsIY6FqES5g9bSYh35tD9QEnGYktlpn14if
	MMGsNLrAw7gkdVF01S0VSgI3QaQdOxzf1xiTlau8Z+3i2uAOyA1JCsFP
X-Gm-Gg: Acq92OEDQDTvVFDFSmDOFjYeAWI8AKj1wZ4JrZToKSEtAr69C1cX9AaPNutX38f5Un7
	rkIDH92NgoctKh3F/RspwOFBrKVcw6IRPHcj/xAkwoHrc3NCBdQsvHWrjPkzo2zNMVe6nhCkzp3
	3//ZehJoerZb8E9Lhqq5LoAi9jq5hGDy9qPPGVx0cM+Kms7lMX4Ln+DhrpSpt01xngDJQl7PaQe
	5GMlOTCWayqdHWAMHVNYj7GHF5eXOSJAqgM/F5d3YuSD4hwBtKgp9Dyu8sn5k+xuruzR/+0bq9C
	hWBBOvdId7WmPSmZHeMlqIpMaMX78HZ1rC60ipqGeJQlStSMzW5sBL+sXI+LFK1+VaYUFemH7a/
	RCnBxwPoZEOLU4IgBxYsKEeUMW5xNAdwK3xAIJF9toXs9IokiyGZEMuyia7Oz/LzL3dxapQimj2
	WBWkx0qqJd/z/Si2PiEzDwQHW4aAOH0T6thk0nVuXw4uE2hdk=
X-Received: by 2002:a2e:b8cf:0:b0:38a:365c:8416 with SMTP id 38308e7fff4ca-39561ca1027mr30963781fa.3.1779277293466;
        Wed, 20 May 2026 04:41:33 -0700 (PDT)
Received: from localhost.localdomain ([213.230.116.218])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395887b42f8sm29778261fa.36.2026.05.20.04.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:41:33 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: grondon@gmail.com
Cc: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: Re: [PATCH v2] iio: accel: bmc150: use guard(mutex) for mutex handling
Date: Wed, 20 May 2026 16:41:20 +0500
Message-Id: <20260520114120.14814-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20260520101247.64458-1-grondon@gmail.com>
References: <20260520101247.64458-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
