Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A63672A8
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737820; cv=none; b=oECwKHdAhUoElWTZbzRLYVSOKhrl9+CMYEHHKdXSpg/AwmeiYr07nA72iQ6hAHhOpP4u+06LQ6ujTwXE1Gv6JbpCjlgGxuScgRI6r95Q2u/oyuBmGJOYktrGkCnMfjnRC9mLOZ5Vl1bYH38/HsLn7uZC929bkwEoz4c8hdidQDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737820; c=relaxed/simple;
	bh=Tn+c/zVo8PzRnNBIqP7IheP4YXXfDe3l7UlIWLPcoW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1MvcQ9meKQ+SO++lSrveLP9rSkdKS9hNAlUFrSkYeQW41lu7Ze6l5iHX92HB/C2HqO44Lp3vuqib3+E6VL0yLsB2ACCk7vQf1IAHFdCtuKN4i5Qseu1t5lHtGGyDAZLpuJQyf/PKjUZTJcxjDfCaUU4YX3uLVjkRbK/JVNIxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UF+VBes2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UF+VBes2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6491F00ACF
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 20:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737818;
	bh=Tn+c/zVo8PzRnNBIqP7IheP4YXXfDe3l7UlIWLPcoW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UF+VBes2S7m6E4JbXg0HW2EjXQANaV9EAjuP4ctXx9Sp2g3IqvAJz0btJnV1Z85n2
	 GKD837ptsrmfeF4mKQwvPEfJM46wY6DuF/ZxtZ0h3k05OCxrm48hRMZ2PrDpiNGaoK
	 QyOmiI4LZRIYT8OUHb3wjNMDX1xSRqNAr0FHxpqeAWwNXdGzxYu1WRXshju52uLjzK
	 Ge19VayoBZ3xIDWKUkKx49G9SdhzikCF88RjLEYjllK+IMCVTViKvg4vIKlLLHBskZ
	 5fKKrseYHIBCPVyd6QvZGtBOaxSdGxSOZvRu04vOJj45XiSmoOr+L6Ela8rvRqqt/9
	 ZGtV/WTk9ixSw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1499356e87.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 13:03:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqdtUu3v3WA6aBckyFYLrOnFfy9ahtZsJ+vLJscDkBcRKQKylCgWkxLrFJssM7o4ioKYn+5so57EKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxncHiSJZTK67GXdwQqUiCNFp7xQvBOH0RNi+ZjhjV0T2UEORSb
	Xw8reVohGBu/yqkpapXLq3nmyHuqHLFYA6M4qRdYDFNbuuyXcOnwRAbseF36Dc11+w7Jmcsbj05
	ZWEINyU1aEENNRUdk8xflLNJlZHepFIY=
X-Received: by 2002:a05:6512:3f0a:b0:5ae:bd4d:852 with SMTP id
 2adb3069b0e04-5b459108af4mr1363361e87.5.1786737817557; Fri, 14 Aug 2026
 13:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814101845.301769-1-yashsuthar983@gmail.com> <20260814101845.301769-4-yashsuthar983@gmail.com>
In-Reply-To: <20260814101845.301769-4-yashsuthar983@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 22:03:25 +0200
X-Gmail-Original-Message-ID: <CAD++jLmmmJ1TFtMup2FwR_J+Em6psg2MRAGZdiD1yzP_sESqFQ@mail.gmail.com>
X-Gm-Features: AcwNN1VaHbZF8EvlmOfEoe3Yh9_7DZSzlqCdvWFoqSBHbqzlobU7Q0nz4cC1y2g
Message-ID: <CAD++jLmmmJ1TFtMup2FwR_J+Em6psg2MRAGZdiD1yzP_sESqFQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: accel: bmc150: use iio_push_to_buffers_with_ts()
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, grondon@gmail.com, hexlabsecurity@proton.me, 
	sakari.ailus@linux.intel.com, srinivas.pandruvada@linux.intel.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:19=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.c=
om> wrote:

> Replace deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts() to allow source size runtime checks.
>
> Suggested-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
