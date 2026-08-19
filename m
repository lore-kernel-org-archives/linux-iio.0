Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75B38AC9A
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174589; cv=none; b=i3WfKi6wDUnGtHau45BxrNA00w2ou2AGERJRR11rED3LWb6nQhO7PHbkmkKwSaw33aSeHCe36+IUJOjY7EoSFQ5SLMGEdnkvCIQIpWptlyMtcuTneC2JKTZ0+YLkAwyJ8I8tab7iLlImZeN2OtXaoC6JPOCc7IIJAngsjPto81Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174589; c=relaxed/simple;
	bh=e86+tyxRdQKzE4t52ZefcteM0bRE88sbIL68NZYIiAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsG7see9xh4vFMPOEkpq5f7hAncNTl60tXeJppN0XA04yf+2mOq1gj3cEkzAq/LS9NDZJQijM72biVJ+zvEooIu8zAKkTjoa0BHr0jnvoXn14a3C2i9O7Oxo1cAVNjI/M0+Lmp7mXaXst0r44Wp2UAbEfY5hWBdKAI94ohDUdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UNzU2lCM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCKAFLrZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNzU2lCM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCKAFLrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787174587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
	b=UNzU2lCM8vGP/ynJu6UYWXGCk6w7dVDtbXs2Ew1fNbDLkeCPOIhcDCATa02P4Lr/I9uPYs
	JYUM4xPAGMT8/QeMWtuONz+/MZ83Pyg4nQUPdIILyPPeqtCkhUNLjXCpQYeKCRx+4tbu/d
	NxY/KmvxMtzjxg6jPMx4fJpI+bNtpyc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-ZqLQYtkKPa2qcaU_VH3i6w-1; Wed, 19 Aug 2026 17:23:06 -0400
X-MC-Unique: ZqLQYtkKPa2qcaU_VH3i6w-1
X-Mimecast-MFC-AGG-ID: ZqLQYtkKPa2qcaU_VH3i6w_1787174586
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-9083b049f73so19732576d6.1
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787174586; x=1787779386; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
        b=JCKAFLrZWsJlDyDL0n3WLYXT63egpUnZ+e9sB2o8Cu52PYgoPA+qrgX0HMk/lPmuhg
         kcZ+OnAOPFAPoYKI9SfWNtt/wNFfb/l1B6Qdpjt9TXkwa43DK7+RdPkfUnPYcbSp4trw
         Y17ETv81mfJFnM6opMhSYQfXk50NGBWU+qwk2peJLmDw+Ewga6+okxmFUof/ZIMerVvb
         1M+0Hzo+ltWLG+vER+nwoKKVNLyJN8Nnj9uBk8EtwVn/j5vuBSOg0S9tvxz0J4D9NJmo
         mhM/RptbedIlUzfhAEYhLCvT3YX9QmZVBkAYg7TGMhcQn3/sfMzWQIBbnVAkWKY11f4X
         qF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787174586; x=1787779386;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y2Nq6oWt/A+GglsE2R04tSZrXRfphvvWNtrnE+gHf8s=;
        b=aJYgD7O7CFW/npF2tvKWgLD0o2U/ubg7i4xsUTAlQjz0bCNFY9qxaOvnLYE6GlGAwG
         w26tMtBDArDppVIhgHq3S+5D0h28kP9E48w0EJM953PxpU4RPtTeXPW2988wxF/Vz6HB
         Xf498zJIp/l+fYJ+8MDrhJLN+mirZiQfe9TjuWPT70QMF2RGkkg/VW1SsHSPlGv5VP8M
         11NZYith3d7a7eDPv+XUadf1JNRDGDF1n9f4JSE98Ov0NAtWFxNuxxO2kjjKIyE198ho
         0V08syxSnbi3YssMQHRbLZbk6HbIRtr9B4k4JOSaWOnvB+TwjXOIgoyDHoktx7U8OhEr
         cbWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdxOtc413QZ65PP8H3EIJMeGp55rhun1GbsqhvAc0e4XlsaIulCClBnfjKFfQAWJlFJ0HaBwUBu4U=@vger.kernel.org
X-Gm-Message-State: AFuF++m7h4ROc+obdyxzI8uNwT/TVV22OFEY8cDz8Qsk9HvwWOaB0jym
	3aIdkugM0nUoHtDmCgkb/fLiSqMxaEEUzvaCQ98j8pQFMxKLAOuBK8ADoglOrnY9OSOvs+LEQA/
	IXxZIDogWJSLWWDe/Y/Mx3UKKAj/J0qPu8awcssze/d5oiWK2PfnMBOu4uGLhig==
X-Gm-Gg: AR+sD13o6DIsaXgbf4PmzpusIa2WfarTePpEsWBXPw8YeqHldCe2JRBcGFzXKdCa4Lu
	VabuDimQ0cQE2oY+R0T5tNvEq9JYFhmm9oSiDNsefh8GV98AvO+RGFf8+GgAkUiU8OduEZ3PgWu
	MTO0th3S3iv4M/MfSQ35I/u7FebuBT027ed+7cP0hqXwn+dfDT9/5cA3OYv9jx5Nsn5RvHk7dzV
	DAWueDAx7C5bxoUQMIakbAYVgmpmxYLWQQHxdnOhgy3Qz/O+aIJpQcpKqr9Yw2W06caGRDP8ZnZ
	bCOY0SuaUU392s00RAhcP73LXZavm8lTccGk2OvR8YQh9s9Qffjj173E6Uv6pE4jGZ2u04cGzpq
	vHVngZHeMIIF7RXmRkkkchBRnF71vlbQKW/c=
X-Received: by 2002:a05:6214:260f:b0:90a:804a:968e with SMTP id 6a1803df08f44-90c5eb8132fmr77665636d6.32.1787174585748;
        Wed, 19 Aug 2026 14:23:05 -0700 (PDT)
X-Received: by 2002:a05:6214:260f:b0:90a:804a:968e with SMTP id 6a1803df08f44-90c5eb8132fmr77665056d6.32.1787174585342;
        Wed, 19 Aug 2026 14:23:05 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2a1139sm23455876d6.34.2026.08.19.14.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 14:23:04 -0700 (PDT)
Date: Wed, 19 Aug 2026 17:23:02 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tero Kristo <kristo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Nuno Sa <nuno.sa@analog.com>, Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hwmon@vger.kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH treewide 5/5] spi: amlogic-spisg: Make sure clk_init_data
 is fully initialized
Message-ID: <aoYetnpb5fu2M9u6@redhat.com>
References: <cover.1787165329.git.geert+renesas@glider.be>
 <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fb35ae0aedb7a6db0db6c78a8193c7602dd9d44.1787165329.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Wed, Aug 19, 2026 at 09:05:19PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> aml_spisg_clk_init() fills in init.parent_data, and assumes that
> init.parent_names is NULL.  However, the latter in uninitialized, and
> thus may cause a crash.
> 
> Make sure all members are fully initialized, to fix such bugs, and to
> avoid future breakage when converting drivers to a different method for
> specifying the parents.
> 
> Fixes: cef9991e04aed330 ("spi: Add Amlogic SPISG driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

