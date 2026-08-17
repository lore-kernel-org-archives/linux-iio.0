Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D0454781
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976129; cv=none; b=PQ3GUW87YdmHyJjIqRd12c0IDDcawaAIq61QKt1Opb7dJzO20mz0Ie66O8KhxRB5EgLbzlxkHw0T3g08TNHJwqFtPN1QPOrnLhca5RINqbXBFLeZM0efGMr4VNiC32TEhNZcDmEa8VqxvbVBpFFjT+/3/LeihUq8fYEM4DxCAOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976129; c=relaxed/simple;
	bh=khoQ7L9VZjC/PNAUQ/Sjr9kIhxNa5Xx3U1PPkaqU5dI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IypZFJjQ19yJLyTt3PKBij/4fu/Y63ZY14NuU2T/lG9qJI5WQhCK19zjxpfBguijVMEtKvsmdtc9wdV2uFIV70HabWFMayy/xdxdIsem6L4Qz73uvjVe6Mz5ZN+icehaZoITwR/jAi5iv7SZdqcjWf9uHaN61iaAtCU2j8o/YZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXL2jyjE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXL2jyjE"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-472326ca506so2417511f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786976126; x=1787580926; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HJlP1AbCvj0GlzVokRh2GsjzM05mavP3fcHYeATpGMs=;
        b=lXL2jyjEz7DolLF3VX+MA77BoqYm8LxveqPT4NvgxJXT2rHCzh/WfXIhnDvo1E5AcI
         0P7H+Z3EnpDD+n9K1aK7p8xzmIIXQAXH44urE0MG8teME1Gv8TNniIRHQ1OIzLUQ10WK
         d1yIiuuwZbIrxzTxLeoyOl9d8+ahEmr2d8By+uQGEf9Zkv07q4dqxZd3bItcDB0vmCo0
         9pQbvKq4/9zNsjS0Ta7L3yPMuN39Wtd8UeejkEJLC3lnm4yVAgkukpaMdJAIQV+NShgY
         YEKiy6yT0jCZOnJut7AsUqjFGC6BDDI55nGwKt1jdR3UKrGKs3q/gk/oBFg68vHg/AXN
         4pxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786976126; x=1787580926;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HJlP1AbCvj0GlzVokRh2GsjzM05mavP3fcHYeATpGMs=;
        b=SGtraKKstqNJNK0WEr4aRVP1GqZFcWi2/U7TV7EXnea4nX8bAQ6qv1Ys5j3/cbm+Cn
         EVwmrSWyg+N5JnieSx76EoVuK5o8q9BnIlINyzkZ/CtfnPtSYJUyoHSjxHycNMfqO64J
         ogdanqCXC9gRytu0VqUc83/+/tPYQMHAijGpDaDDI+BOK9xsigrMDEjkffxX6MXsFb+I
         iWdiv5pb27CbVVTpiE0Xpp/h79xRGKrMs5HN4rt+UTF7DFXSuNiXvO6tyufD56jfUklu
         dgIHOKBGWpHjmMQarGYc0jkgQhmz4kyQEnYWGgG2IJQf0j3brJBdGDWiKTGWbsScyO8u
         HmaQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDYgf7wGLSZ97VFp+oiPDKk9/zVIs61Z72s+x5iUYhuVpZ1bc9svA7xRWEGtlpISeAAr0UwRoO3bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7Eh55VhJd+scdnJNczKxtQkyayrDCRLBsOjZ6RbzT2CK0wrd
	eX8x8AUmXB9rdf4Zz4uPrJhrAjhwtYIBRxCXdjwzu1hQKnB5zrRPPJRY
X-Gm-Gg: AR+sD10gD7qzxx2PFL+EvgYBTM+UNjlbdqh9OXG09Y6F7UgAF7+uExwyhJJK7w05zAr
	IM4InVkpSZSYD7rx+S5Uk6vLGOqCIAPTXdM3WZALAFdwjPREvH1e32Oepyz8pmYwxfHYHFkkT6G
	FbElMnERUauifUTlPfLMZ86Xb9cBdAa4hV2g5zV8mYzF11xidKrNJ9lS3ceGdADdeeVEvtfBhgD
	42GeoaPg/OYBFehZ2B0k43Tx0pvYyHVNDUnecYEvc1BDg+ADk33PUx6LKNRZAePQu0lzR4A9mMH
	QKMeDItMna3MdcvPzh+6KK2tMgrYQg8y5U/ok429AIk+uzfzdvZTWjTBaYtWJ6feA92DcojHcrp
	YsqAkzSIN0NZsaWf73wrSBoVdTlCenYrMijMrcinHV+jjxAV0h+PNkEfdHTJ08ogrw8k/GatRS+
	ohoS3OsK/qF+++D/Df86oZ5Nl/f7L0ScSSAPMwxIluAFKZDRXjXU1Fe68MCBWTh97ih8oOQIf40
	P/52ttKn4fIrcJ4qXFZZUwlE9DW6zW600JolqtaqmnU+HGTl6+FapCE2koo80Sm18lsmjZTe85U
	BIusf+wr9p6YztCMRquyEDiTBXWCrqdHZ2LjvXviZ1xB6wWZYAYp61ywG0lxESb3Im7q1ZK+CkL
	jcXxuD+indNwqKhHFw3Gn26TghudlFNhDfgYyDrJTHlPOOwzT/Vmtg7qBAZPxuoy6CdC1lA==
X-Received: by 2002:a5d:52c3:0:b0:47d:fc23:abe8 with SMTP id ffacd0b85a97d-482a90919dbmr622111f8f.28.1786976126114;
        Mon, 17 Aug 2026 07:15:26 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5a315bfsm4566475f8f.1.2026.08.17.07.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:15:25 -0700 (PDT)
Date: Mon, 17 Aug 2026 16:15:23 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: dan@dlrobertson.com, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, jagathjog1996@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: accel: bma400: remove completed tasks from TODO
 list
Message-ID: <20260817161523.00001feb@gmail.com>
In-Reply-To: <20260813150103.56350-1-marcochen.dev@gmail.com>
References: <20260813150103.56350-1-marcochen.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Aug 2026 11:01:03 -0400
Marco Chen <marcochen.dev@gmail.com> wrote:

> Two of the four tasks in the TODO comment have been implemented.
> 
> Interrupts were added by commit ffe0ab6a9698 ("iio: accel:
> bma400: Add triggered buffer support"). Support for events was added by
> commit 961db2da159d ("iio: accel: bma400: Add support for single and
> double tap events"), among others. The driver now has an interrupt
> handler pushing IIO events, and event configuration from
> read_event_config(), write_event_config(), read_event_value(), and
> write_event_value().
> 
> A step count channel was also added by commit d221de60eee3 ("iio: accel:
> bma400: Add separate channel for step counter").
> 
> The power management and sensor time channel TODOs remain unimplemented.
> 
> Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
> ---
> I would like to take on the remaining power management TODO. The driver
> has bma400_set_power_mode() but neither bus assigns a dev_pm_ops
> struct. POWER_MODE_LOW is also never entered. I don't have a BMA400 but
> I would definitely buy one to develop and test on. I also have access to
> a logic analyzer for testing. Is this a patch that is desirable?

Strange that these weren't removed in the commits that introduce said
changes... Anyhow, not sure if this patch on its own is too much churn,
Jonathan and the other usually prefer these to go in a series of more
changes (i.e. if you do the power management TODO, you send this patch
in the series). This is up to Jonathan however.

-- 
Kind regards,
Joshua Crofts
