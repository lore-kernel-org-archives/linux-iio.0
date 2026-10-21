Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607915;
	b=IowLfa0fxaL2sqN65/dtyJksoqKKygSxnWKCMss7xA3gMqzIVp1tcL8iy0RKZqDzZ6a8
	 9Tyhv1U/kGigv0JuyYYa65X7u4ivtxYjSLArqwaUmMMwiJ60Du+ggWeYxSCeGh+WoIDFn
	 7+LwApSr0DPkVdb2VqnHV2d21Stq04sn4hkzEnNyN6F0OkPEQVzQS3t+hAd7sfMdrHRtG
	 h1Qatqa298GlwZ49cM9/KJ395bdDaR7jsz6YscntMUuhQbzNWR6V22stND0zTSvc0jK0B
	 F7z2MIhEYNmNYOQPqjf0bfOXRfW0weYbqqxEOOKr6fYySFOuE1CJQLpK18Rr5cjcUMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9hox3umal0L1xptTs/0CqZ4PvaxstwP/QmjrFMXyQAk=;
	b=J7hE50Cs3eW4grmJAj+mgK9t9R0fdgz6S2lySuA5uWJN+lBix9DEv3I8GZDxkY0RBPsO
	 Xnz0PzedvlBZ7kcDj8N7+4IF+csbDe1LUWrK0la7Y/tvY19m58mQm6ZNkvQWKsZA3GgEZ
	 gSY2MTvXfmvgIMjbtvGBprdIbsrtUW6GjmFnnLW8zZMVlsvdFkluPPUjIgquedeuAlJNn
	 WrjupogPC97hhu5zXujgkkwxTWRpa3L1vsH+AS+iP/tTc8vyEEd0TYbxTzifZid+NADj+
	 gFLkr+KaFnoQp24CprLbgO/OUMjCtuA79EB1tqPPW8HEqrhltWMfuhqwXhb6xsA4NiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="O1/oORPr";
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FF8606A324
	for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 18:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39FF8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O1/oORPr
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-156cbe59524so723702c88.1
        for <linux-iio@vger.kernel.org>; Wed, 21 Oct 2026 11:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607914; x=1793212714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hox3umal0L1xptTs/0CqZ4PvaxstwP/QmjrFMXyQAk=;
        b=O1/oORPrb3W/kl1Yod/TdFl4dMRkBr9k8bRLN6akM2zGN6KPipLh8dFeI++me2X2qR
         Ttwm6JplNEIhkk8j0vy0q/q+vrljcah0jUxNDsRoR88STRCNuXIycNDxSZYFENmXo+YV
         EhS8fDH9Gouoz+O5dCnV+0Osm411tXYcMChDh3yWKONasCTGTFBqD3aZ9yu0O1HCphz+
         QpCbMKMh8DQ0xpt2dWFtKFpIdOwpNDOhyJ95vvPhPCVlik7tGHC9coKH6rYi9BEqXTt1
         sgS8n8L+s4nkn2h1541TqrxWbu3R/XCjDVRqnSa6XpAzh48w8m/lyXT4vGQMH9QxZ5Iu
         HGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607914; x=1793212714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9hox3umal0L1xptTs/0CqZ4PvaxstwP/QmjrFMXyQAk=;
        b=Xl4RiCAcBKarDwZNJuBmWKF02ogdT+gG6WPQztJpsIrb+IXjAVO/ehlmPpTkodDuxu
         POmct06/0Rz+rwwFW3FE0WdMG+2etvi3BofbPEFoiWy6wFTMHSBV8qf1OqOZGzoFBoE7
         L2zVCue2KgWU0750uoo0dij5cDrdy3VX8k13vShnvgaoU22VT+vjSc6/ekHIlvPcuz42
         oJRTp6nFAwHx9VgL89TI6F5x/DdABaO5WeRezDWUDNpa9SAMApbKk6aFxUfQcsOT5xcw
         WtfoXubGJJMBPmK6XkASyETHLJbc4qz7A7+PHvX5x/fEmLCANOuBQnUcMepvCa8lI8QH
         IJ+Q==
X-Forwarded-Encrypted: i=1; AKwUvBzkmLcq5ReLrj/XF+7/c3h8uDPSwbS5Br4IFPQLIuA22PgaOq7n5IGywnVNRPzzltosqC7RF2B2loo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe6E51v0Qe+4ppuHhIHa/4EI4Z7lEx9PPq/iphEFHBGOikpH7P
	Xby60k/6PsdLLASLShyFaQhZEx3M3946Lv6YSjwoaf3kDghLMo/u956t
X-Gm-Gg: AYBFou0rzqS+eAyqE6Vlgy/Q/99X5lluLmzJBZ6xbGvYc5FVXIyH1XnhfFhXru8dOv1
	YSyOb/5zHNLIQEIrJy4bNxy6qMIO/VCCt294lsdFSY8dfZwOeieqwzZrPppgSqZzwGj96IOQSIF
	Q7GQtyihugIU9pdeOSoKa3HbvsZUFd3Csp1Ps4GcZY5J2REHfjYymfHfi8bPUkYihiR/wAyMTMl
	eVN763iaNiGcDgbbG+zQmKx6o6hchLJCuZelXtsuL+FlBgKU4bA+0ah4SLMTUa+r5lESL6V7P2p
	6/vWXHVCbGkSXP8LCoSI6hJS0ogLXIl92p43dpe34LN+A8pSV3o2zZFh/bWXPzekyxZHrzRrK7H
	3ayL7bjQRNE7FMiw6xo8XETWVF2HQ0juIIlIvo1CuSzoBf34a3YNucitWsclehabVlnsokDMKee
	8H7u6GTN7eQTIfgNAJMPsqYU5slnvkrfq30q9gyPUip9t5b8TotNt2RoHeO0n7SFnFNuNFlKs8+
	hy/oUjFodQSamMqg2w0uq8A+GYuC/iuRiNKdy1N5vmGcM3vzkw9sDZUvypiWEVZGexNoljqwmMp
	8K/BNNzJDdS21awv+QiQ7UuIOmQHV0tS8ETWAGCoRitflFmDIj+fWE97OmYmm+VvkSjnF4t9bS0
	EIpdg0taRtSs=
X-Received: by 2002:a05:7022:e802:b0:186:5b49:90d8 with SMTP id a92af1059eb24-190a0428f0emr4206239c88.4.1792607914183;
        Wed, 21 Oct 2026 11:38:34 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903aff3481sm8427859c88.10.2026.10.21.11.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:38:33 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: joshua.crofts1@gmail.com
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use named initializers for temp in hw_info[]
Date: Thu, 22 Oct 2026 00:08:00 +0530
Message-ID: <20261021183823.169199-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261020095936.00002ff3@gmail.com>
References: <20261018000924.758186-1-kapoorarnav43@gmail.com> <20261020095936.00002ff3@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 09:59:36 +0200, Joshua Crofts wrote:
> Your patch fails to apply, please check it out.

Thanks for trying it. The patch is based on iio.git fixes-togreg, on
top of commit 2b8d4cd20ac8 ("iio: imu: inv_mpu6050: fix swapped accel
and gyro startup times"), which changes the neighbouring .startup_time
lines in every hw_info[] entry. It applies cleanly there, but not on
togreg or testing, which don't have that fix yet. I should have said so
below the ---, sorry.

Jonathan, I can resend once that fix has reached togreg, or rebase it
however you prefer.

Thanks,
Arnav
