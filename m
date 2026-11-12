Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520176;
	b=HfnwMTFjAnVUF3FNxHvLX9315o/Y3pC3eWHWLGiTlYsXEvcfnk48/26qZp2qN8FG28El
	 x+J6DeNzv2qPkQF3Cg708F1+o3qZ/N6NSKsi1LDQVJIZCxwmeoUlkt2AIJtq5y3jeWQ/H
	 NQHtUpHI1V5lTtppnsNnQ/Bl4nYPsO+1h67b4kP101AcPTcacQINaMFNKGmbzEB7jfhtL
	 vDXnf7XG2ldrfnfA+U3p3bx8aOGdJYZP/DXjcSRihDuQ2PsfwRI364FQC/pX4bRUiWsOI
	 EON22024opSY82xgy2znEyhzxQXEvxzXCgQWLMtBUSg8CDCGUxsBwSIzY09REPfBjMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DTrX37NnxHAmnian/0yG7KNel7p8MfKNdEYuceQs5Ao=;
	b=nY69yRH7v5OqmYEXyXdcLsAhevFub2xixxojJYCXaklUXAQgThJdiUUlcD/6P1jReShO
	 GH93zDrc5JbkNrRf7cJQz5RHcClIuNDbn9CqZxOsS6cK1Sro6OSYbBgop5C03b3w58C+o
	 8vs4tV8JF/6CNve42UvsEXx9ULrdwoc24vULpnws3IO+9D+AQhP3Tya9DLHr9oa0Ib6D1
	 Zrz8magLRwRFHXoTLxYGnpjSZiZUIdw7W5zqVd2zLYeeFlufyEWaHC6Y3kZIb+q28glcH
	 POkPBWv8sjJe6n30chdx4xe6pvqOw9rXqIemxFz8YOLpl5rL9DCYGXO8xgL5+BigQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eg1T9e71;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A694606A323
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 21:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A694606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eg1T9e71
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-37986eb6fa2so159712eec.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 13:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794520175; x=1795124975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DTrX37NnxHAmnian/0yG7KNel7p8MfKNdEYuceQs5Ao=;
        b=eg1T9e71WacG4utbBCm8Qf+llQAYb1SH1JPe4hnvflOKIO0wu7bdFlujYFGwHu0PBs
         ossSLsq0JCdgUzaxxcPcgFCdAOjtp69sKSDsZBicRWzBez059Vjl3KC+76V2FWQf0SEE
         ucI8YCpXBLnJbGRcOKq8Vq501RjJqRoEXZCpE+d/xzsCHG31uJMarjvwaQXsWJwrKePY
         ciyubsXc8vjcstHPeBxEEwCX/gKWE5xO4+faTcOLx8Uw3SiH14yiuT3jf43zC/uLlo/v
         URgsT/kxjHE+pzaOhQsIHMHNkw5uCLcGPTxQmkC/Hr7OlVQF/KDZOdRarzPftmiE/4Xq
         kjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794520175; x=1795124975;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DTrX37NnxHAmnian/0yG7KNel7p8MfKNdEYuceQs5Ao=;
        b=QHTvxKP3VMaNTj2TT13LSrWWBYK+nOEwzBwIj8ExRkvEQXD1mu56gX3CcyZZlgltm+
         /mQgP08AkKoF7OA6Hy5JSBGCPBWgyi59jZlncD/64Aaahj7ElBikz1zvLOO2UEBtYgzS
         J3mwRMUazNeNxtiUqNkpcKIEBpEEuMV42r0f0ceCixDtrzAZLhNXkBow8+pjiBmcVvLN
         FP1lj3GPemln6O4FgM1m+CtDD49Lrl6Q+eNEb/PumK5KM8ELlooVtbgSab+9AJqa9fu2
         sL+5DdJaaJNK0Qd2W452yQ3LrxjzwlCoch7GeaBkua5vwidkhQeoca/ac07frPoIoodr
         a5Dw==
X-Forwarded-Encrypted: i=1; AL+hErFVUNN/2jKbtb6dZMp0UxQlQvwYFVqzAqZrTwATKPbfDN/CPhFPJwBDzIwSUDWyKUvsqYqsRg3VT3g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+vEZOTsP4Z5dPooHdCYx+wmtoC4mBJb8IRv6ZoZ3aU5QvieqPz
	GBOAQB+y4xkEqY3ZJGZSoH0nYMdpYdLT4mA1AqS4MxskxDOmg09qog2J
X-Gm-Gg: AYBFou0Q+zAMqvqraVk6X5v4v47MFsGCVohn4BS/P0npPOhOvK4oLimGFvKDqSHuZS1
	Bnn3SBDWTZrZ3BE/W5744ElRZV7xC+4LcHiTJ/uTqee3jvQhzN5xd2g9i4NoegzwRGtPrQa1sQd
	LEQ1N14P2WZSGSQjMcMjbTHmr5mn00WHurMMdMoUE4snF9AMqemYFvwwS2ny6NcGvnrHqrENygc
	70e/ljfAzuBlV1NwbuhhCRM0L0YAnY202NW+WJKCW9zlCQd4x9PBaMj/xjtbyL+eob9bchtkskt
	uXBCvcO5LZRIE6wbsFwxRMq7dw38fgjEVxXEBTu5TwCpRXlT0RG7pjV29fstG0ht92UE4Aeiyf2
	mpdNscKFTfYfWl2DdsjPXcrZsIOJ1TtVpKxrJavid/qMSHtdHdscBby9zQePV4QDfYnTKwcoMKv
	rfnf/QxvwrIms4sDSgNtpxHxM3cQsV+zbSRPJ2gs1yg/uX0y1lWEXTyT30HuhGmFAtQlKDdrAHK
	Bw4jme854HosAUaazmT2PlixbsOrWkvlZ3bYkL4YP6rWycAtCMbKZ5XfEq4Fls0Pl1o6WI2+yYs
	Pu0ubOTNfbHO7qi/klYfkkgV8qbsSiuy0qoO4kTlQRXHkcV7OzZN9vDjvtBbyg/P9On16pD0RVS
	YU+JvVvZWE0w9mfV92HeL5v9lWMqkCPKXDMg/Rjg1GF6TW6to39lzsIplqM0+mjDW7761bboGS3
	knEfq8ylAsPH5/armt/IrwF8Ux8MYj+RGRmlyPaCr/gEaLeXBm8KpX8nOe017iRjw=
X-Received: by 2002:a05:7300:72cc:b0:376:98e7:eeae with SMTP id 5a478bee46e88-37965da98bamr689461eec.6.1794520175359;
        Thu, 12 Nov 2026 13:49:35 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm997209eec.22.2026.11.12.13.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 13:49:34 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: don't wait for new temperature in trigger handler
Date: Fri, 13 Nov 2026 03:19:29 +0530
Message-ID: <20261112214929.497589-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111195118.36853-1-zoone.rupert@gmail.com>
References: <20261111195118.36853-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 11, 2026 at 09:51:18PM +0200, Rupesh Majhi wrote:
> +	if (test_bit(DPS310_SCAN_PRESSURE, scan_mask)) {
> +		rc = dps310_read_pres_raw_locked(data);
> +		if (rc)
> +			return rc;
> +
> +		/* Waiting here would hold scans to the temperature rate */
> +		dps310_refresh_temp_locked(data);

Maybe I'm getting this wrong, but isn't there a case the new path
doesn't cover? Nothing reads a temperature at probe, so if a pressure
only buffer is enabled shortly after probe and the first pressure
result is ready before any temperature result,
dps310_refresh_temp_locked() finds TMP_RDY clear and the pressure is
compensated with temp_raw still 0.

I think the FIFO path handles this case by dps310_fifo_hold() keeping
pressure entries until fifo_temp_valid is set by the first
temperature. Would it make sense to do the same here with a flag set
when a temperature has been read, and wait for one temperature in
dps310_refresh_temp_locked() only while it's unset? That would cover
direct pressure reads and after the first sample the scans stay at the
pressure rate as your patch intends.

Thanks,
Arnav
