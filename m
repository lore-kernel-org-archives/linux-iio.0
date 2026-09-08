Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38A8357D0F
	for <linux-iio@vger.kernel.org>; Tue,  8 Sep 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884891; cv=none; b=bXNKGH5vkNtslOtWNTFRvtw74RPiwMCMRiHcazMKepM0hg9Kw1e04CWVupGK4AeHvn+qrK+zGwpn9OFa7BZHUm8R1pTmqxpDrFyExuOrDkpvWC6wvBEZRzT/OqvsEjuizi47SCqZYCLj9smr9RbNWZcTuSWJGSAosVEUb7fkImQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884891; c=relaxed/simple;
	bh=QO7aVxN0Kc+VeXFyVq2eLzoCiKN2sTlqvt9+lPTHH2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMPZUoBuKRKTPzCsGobnetFrcVT19nuX/SvahK5NWvtdHjjo2+HkGQSxyoz6TZF79Eg9YS6UyWvygGDZ+SEmjfbUZ72uciN8949JG1cS2DbKd/eEYwKEyflKdIGlSYJ+IYO6t1xFzqAUw0bEg8QxBytR6jbT7at71SvgZWFU3Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rm/klmC2; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rm/klmC2"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so7920825e9.1
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2026 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788884888; x=1789489688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oer5O6BgRKMcoJLGFe6Krh8JHdSb+cfvZG9u7xMnm+0=;
        b=rm/klmC2ltX40v1TS10Ogr7E3w8kf4/NHgLyTw7Sk1s4xejNZPDNTOXF06n8N/4npI
         XMyJnlwQBCDC61jD6WO1XuwzKLkaptIeQI47iyikogqshuJRBfwwU5+w8dY3b27IrESn
         JiLFHIs7bwGRi98bg+s7kQITuQfHsWapy/zU4NyAgdz+dImICcdXYC9mvwAs+dqDDbR8
         kpph9AZxXAErLxWr1QzCntY+Y6o98zgeZ2KH6Jxayjwu8dhE/p7rWbFNhVnJEBY4iLLJ
         hIq4Ezyo1M2HDGcAYHGXHx8n230gwvDo646QMt/T+b6GSDvWFlqC0yEjCd2zbwsGLfZz
         XbSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788884888; x=1789489688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oer5O6BgRKMcoJLGFe6Krh8JHdSb+cfvZG9u7xMnm+0=;
        b=Q2wvga+qxyfQRsuv191bChu7RJZQDZpMBSQmanZi5AAeGQLMDuuip8R6reyA3mKseG
         nCgKPFscuXlWcCHtdUCb5qjgs4QPysaGj/bnPTm6WibdpCaRn95qvN7qGK4IhTT+w3+Z
         mmNeeC2mi7OW3XMulJ+pOctQa0KXRrbSQ8hRuOmgZj6SbJ0bHzYAB3CgKN24DVijgtp+
         vI6FetQbwxPYvStCFX+sRvXZlpFPVv4v+4gz9yvEfVZHjgqsH7uqadlIcfDQVpPNozkK
         BiwdmzkTAKVzs4zMrZNJrrESZmhG0ZpFzyx9kVvtieMBN7tDYckJAKfc0OSxMKNbDwB4
         ixMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAcEFHLgTyT8E+Wky//MlOGfQsxpV65RKq2t9rrDgPz4QyHqwJRD1Jcgn77wH3Lr4QWwdzXvXq0Qs=@vger.kernel.org
X-Gm-Message-State: AFuF++mRktLVrKLhaBjt/QEg8ibiBd45wk1SH67El7KD2LIBZ5pUdK4i
	HPD55YVrB8jyq95dtJKhcly6+Rmy0gVVMhouDChMhPJjAKF5IJbZ2QQs
X-Gm-Gg: AYBFou1kBhqgIbHp+j2qPEA1HKoo3sVnJ+oltpvxtsYc6YAqrSPAgRshSFYoelJQBW1
	0zDeZASZ96Iu+BYw3osfY7FNEqTAzKVOti2tbrpdbsLlU5ElFuUhC/37h3dJGmdXuu3O91qNvMb
	ZV2d06Yq2LpgrJF99Tl85TMTBsNyrgrLBpDaXXHVPjHYcG0B6350tO12Ugsmawbaqcs3sP4VWsG
	jusU5fi1u92AvYR7eA2iniiQ/TzrZjDtyeYOSWiEjREnMIS/4xTN/b35vlTMGE8NMrK4JVpjFPF
	oM2jD5LSKyt28Hrn/D/woxeLrjR4QUz2OIAN+oCuu8esYbvj2vJrr+ke4c4YqmhAV8uqnK1OR38
	XEoSZgj9YVgdLHc2kqcD5W2l/oOsCBTecK75aaHWOaceGfv8mVWQvK08XQ4Fh6K9rQnUfcbchO9
	RzAxNzUrKXXSgGlABSAf+Q1VrniroPJU0fD3Z9SzOonguyK2VNG7suGq9GjxJoGvIDNsojQSwTb
	XF1SRUbJhtPDPxkLRH+POv/qlb0f3zOt41Bquet1Q==
X-Received: by 2002:a05:600c:1c21:b0:49d:1e79:35d6 with SMTP id 5b1f17b1804b1-49d1e79368dmr14997255e9.14.1788884887754;
        Tue, 08 Sep 2026 09:28:07 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm42028093f8f.25.2026.09.08.09.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:28:07 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads1015: Add label property
Date: Tue,  8 Sep 2026 19:28:03 +0300
Message-ID: <20260908162803.5400-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ap-SBhDIJGvFZqFd@ashevche-desk.local>
References: <ap-SBhDIJGvFZqFd@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 7:41 AM, Andy Shevchenko wrote:=0D
>On Mon, Sep 07, 2026 at 06:23:03PM +0300, Flaviu Nistor wrote:=0D
>> Add support for an optional label property per channel similar to other =
adc=0D
>> chips. This allows assigning distinct names for each channel which can=0D
>> match the schematic signal name.=0D
>=0D
>You missed a cover letter.=0D
>Try next time=0D
>=0D
>	`git format-patch --cover-letter ...`=0D
>=0D
=0D
I will keep this in mind for future patch series.=0D
=0D
Thanks,=0D
Flaviu=0D
=0D
>-- =0D
>With Best Regards,=0D
>Andy Shevchenko=0D
