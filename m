Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AB3D34AF
	for <linux-iio@vger.kernel.org>; Sun,  4 Oct 2026 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791110653; cv=none; b=dwMB/Ya2aiQ2qDFwMD7kMhn+HXDzJkbbjP7Z/xEU/k6owtsciU8sbel+YgLbjc1ph0aeZHTA05LWZLXdeCsEmBRk+CnHQq+v8rwNFBjPjoowcjAcGctcPANxYkKVSvzeSQHnrTie9t+NhTkY+t0h7zfhQhq2MEiHsgVa+veCwgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791110653; c=relaxed/simple;
	bh=kGjnWXyZ9NQf4aKnHYHj9cq+0Gg79KBWpte5IIsGB/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olsCyQpdmUU32LRep9tPPlb2v3sVj/lRdQMGI9AvHy3e806veEEsgW3Jx20AhwPDy5maUKCKDiLGv78lD8beOhdkOyTOTeSlFZ6Jp2AajGOn19FHQst+ur3p5y+AP1VvvmoNEzCTyqnR4Ha7PHLO7qBXX2C2QsiPggvEapf9Dvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swwGWgIl; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swwGWgIl"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so923541eec.0
        for <linux-iio@vger.kernel.org>; Sun, 04 Oct 2026 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791110651; x=1791715451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kGjnWXyZ9NQf4aKnHYHj9cq+0Gg79KBWpte5IIsGB/s=;
        b=swwGWgIlosq2wuRvbVHoue6Yhz3qOIncO31bvjNYoHabvnFq4E8+GJNkKWLYdT7Qrs
         bXweSb5f0WkwtVrStIIKXBXi77l+Pfag6whD8e4uk6bJMeX5TGCF+K1yjkcUTLmClSla
         pmu2H/qxq5wOGN1pDARrwfa7R/kV71Z/9Prl0Fz9nBM3kcgYEE62U6zFI81afaYITnCj
         vMYbCE7pZ8jV84Y3fehvjR60ACAe3CZoxZsPQuxf0ttQfHQctFt6xwZ4Un3KcFhMCPbS
         BVjNPsmAalEtue2Mo6Mn2/1ak86JWlDSpfhPIKh8Lha71wnC3XCIYWCQRmA/PqUyGRDA
         sxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791110651; x=1791715451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kGjnWXyZ9NQf4aKnHYHj9cq+0Gg79KBWpte5IIsGB/s=;
        b=tl13CIeq8FoaAO/iOi5MPDYl9n/KVWcXvHAJjR0CqjEEeW5bIhscGSyduSBJdR+nDT
         udNF2yvYVuGWSTeUfx/uua0cLT7YuvUX7JjG1q2XtwL2oiOhb/usT+PRxp7qB9lQ3uPD
         jvpnuf1TMXwaMoVwUkee/InW5KV5Nq/QqW6PdPXlz4rY0CBd0MwxWXWXC0B/v9Mm+dxJ
         t0wVe1ox89ajFasgc+XN2W4aD1AjcvWrDfk0EFLWBFoxLglJ4K2UP/gAhFdJ9Ladf1DE
         mbYbTw+9GAULP5YFieKtDQ9p3cjwUm4yjlL9kRJqt91WLdwb+p65qhr7yq37/0w4AQk8
         qybQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1U7u1Wzr1L2zxj7nRcDJz9jIuy9HCkcfHcdq7+3g2k4mq1XYqDttVEA9CzwV39yepQxvJSIdOHCM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLC4ipoyZKipXyai/c8UBanzIGzirMi6LiLpXBIj3Y0Pls5fwPv
	nazc738jCs0NAx+VPR0WfPYQBmNoBtbZ0Pzov0Gqy14+jAQwmsBrkhE7gH4wpVxCJew=
X-Gm-Gg: AYBFou0XY61xJWP50Xi1NJvAqQNj81Xeq3CU8NzVxFhchkobtEEJsb5pmfbuD7ya1Z0
	joszkluF22VdGxKmiXlYmMi8OrZPK72Vep1Ct6Z6Y6PsHzxUFn8AtpWFNTr0tMTe3sQZTZDruKL
	7OTkAVKaMQ6xKsMC/wR4hZwmYnPD2/VsYzzQnB7GRMGCC7CpnXic3qWipjDr7izfVpfCpU/OjIx
	ew+NvO/hG1hfRsX3gIhnv0B4wUuQ3FSilwiTXXSlVsuiQcIQ6pNZjhr1ejsISvR0ThpR7B9e0O8
	g3I3nrdzwBssG/0mGSVjze90A+cyx000AKA5rS+gTxDFVmXpc4FiZeQLsV1s+gpFQohV2ntzvUj
	o8+kfuHCm0magV01Y28TaNDRzRgRAd1+r0jV94r6p/mk2zX3igSlXGK+UJ+jDDXJPxoaOD1hA4A
	AZ8YcGQsO3262FSztN4ZSrbOzV45ayXngEEcLC2YELPDpbZbn5Fj4YINkisEHYjTsJVEbbiDspX
	q//zbiSWRd1mm7BNk2mbB8UcAkEewPrymbYN7yZWo6KnALhtt30WG1LmgELtk8263BFo1E14EUn
	ABLnL/i0aLY6d/r2
X-Received: by 2002:a05:7300:e9c4:20b0:351:1e72:7470 with SMTP id 5a478bee46e88-3511e727a9cmr3932747eec.13.1791110650783;
        Sun, 04 Oct 2026 03:44:10 -0700 (PDT)
Received: from kapoor ([117.235.129.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351277a2fb4sm4159012eec.26.2026.10.04.03.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 03:44:10 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: andriy.shevchenko@intel.com
Cc: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sean@geanix.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: drop stale vdd_supply kernel-doc
Date: Sun,  4 Oct 2026 16:13:46 +0530
Message-ID: <20261004104402.83215-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <asFV3JlT-YNYa9vw@ashevche-desk.local>
References: <asFV3JlT-YNYa9vw@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 03, 2026, Andy Shevchenko wrote:
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks!

> > ---
> > Comment-only change, checked with scripts/kernel-doc -Wall.
>
> Is this the only issue with kernel-doc in the entire driver?

No, I only checked the header I changed. On the whole driver,
kernel-doc -Wall also warns about three functions that describe their
return value with "Returns ..." instead of a "Return:" section:
inv_icm42600_buffer_update_watermark(), inv_icm42600_setup() and
inv_icm42600_irq_init().

I'll send a v2 series with a second patch fixing those, so the driver
has no kernel-doc warnings left.

Arnav
