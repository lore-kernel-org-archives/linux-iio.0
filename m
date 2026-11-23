Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795416038;
	b=GtLjQXfKa6MqOfUFdPVRqgHvc8ROzuUzbJ+6Gkh3su5jVtPozo1VM1nFMWEsfbINEOrF
	 dTbVa1r7nbl4CydX2PiCpvzvUmCh6iw72Jqru1sVZhup7JJw9U59n6CBz7+Yc26WCBsYx
	 xmZP11faVr4K6ylztNlrm14SJ7Rmhb/7eI+/Yl2qHsV326F2ii6Z0z9/pong6UgPpabiU
	 2n1mU8HpNyRCKt6wx1C8iIFpO3yvDwW4EDtlYV+ahHixSTb7xtHulPBAYrZX+yS8nXOjL
	 DvNK1SA2GTa6cf4VPOmxtifCKyJrSq2Spo+AcuLEL4UgqYRsU1w3tj8MIagiZqlQ9mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416038;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
	b=yQMfLsfsOyV/+RDwexo3whdDRRsrW6iDA17OXPSoBcbc2jGgWhKzZu3CChIGs1WjW2YW
	 DIUBtaHAaKolH0zd5uoJdI4QdEScVl30CZvKGYrrqoESXnA1thV5uhxFw8W5HRHKlJy5g
	 uKCRoOyPEjlYIiAHc2m5ln3DZXXDNSSrx4wJCFdpjUbqDQgbQ6AlEflPMCJwXrxkG05dz
	 SzI55F8G4BlsxSL4mBcyP/VxoHYdBXM6LvbibYfjtUf1YQbri8gZfTOldVeeLgHa4X4IM
	 J7ZAE0pjEDuzhn+rWGP/SqnxugxJBs8MeSZIiLW7ufscMvqPVrjG45Li29/NaJo08sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tj7oNz/g";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4306E606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 06:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4306E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tj7oNz/g
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-18818daa3e7so1715077c88.0
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 22:40:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795416037; cv=none;
        d=google.com; s=arc-20260327;
        b=Tw+dm5U0FXOPhPKop5NNIXm6aql2Yyy72oQ5VhtHx2sm/EbFKC1kQBpYoVlSaO/fEE
         n6uYFf2XKEoGz9SLCYQ0a/wqL+/TYAD7onF20hqnJEejPSYILoAqfyDkdTLG03VXY2VQ
         Olr/b3ecI30/yl+1YfJ8VFhWgWvVJ3f5jA58Xi4JC1vPVZV6IqTU/7EGVLdwOy7aVcSU
         2DCOUTIh4l3PqYMmPK027wje+AQX2lxU6XVWCQsCLEscps3/Og2/keSe56ydyeUMRJAB
         gnDYpSK6JQsfsgcPjXD8Oe8kR3eo1qaVlTNdAcveRgWXxN+UqijnUxHqv5GZRHPFliQD
         HPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
        fh=AQz6CBtEZkypf6u1KASDpkkGId2JCgXHIwSrEc8/PCk=;
        b=qMjvZb6JMDvwu69ESpVBeSxp17CcoEYQtFZgALeuJQv/NhfjDJLlUlMaCK1IAwgtEJ
         DszoPq1N2vm/pGIx5mgKwuBHTsZoYihYlirfjtfL5jaqoUBAwIS5VDalqW1BnBsYGQk3
         lxuPWSN4MlOEQTMMl3Rd6qyN9xFNAohFwIR9q5Jp+BP633NBKHJpBMb1YRZBeV0ApIyi
         L+agThL3Z88PtwPJxCG7PT1ig43CVXC5RW5g5g517krQbIBYV1Asej1PxD8KeA2haT4U
         kW++ukpI6G6l7iC2LcCnVTlHwatRbTMOYChOEF23QKFJhZ93pzXGPeelLBLgC6Np/sM5
         HY4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416037; x=1796020837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
        b=tj7oNz/geF/WMXYxTdQF8S73V971uV/32Yq0koMbSYdL/PioOpHn9SOBzqOlqUljxR
         8ssbWO7m06sjuxD7HxI7bNAULBrMuiu9iy0BKjrA+YNVRlDDan1yRAoJUklSqaifEZ3w
         deQAbjFhMSsBlsXexIFRTdNB/uArYZjbPGOd9N6v4ii37VMLx5LeKoIj7bvDeK+nNKfb
         gzY77YNZTvfMsKYY61cw4NpGoa9OsSWbybgZqWzuys5/Zd7KevJLcfziwsFg8FRwMtf1
         H5pDmahyoil88gCFeziexDgRA5VoG1aPlfqmpZXxx5tVSz4+f990JEqm/DVhaYQ5Xq46
         i4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416037; x=1796020837;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f4a8zFdSHZW0pYRFKYGvDhkp+r4/xiv4IAwtu7E955w=;
        b=pgLsOF9jXEgiXnYFtedtgcKAmMoVYs+2OrGDPZ7pS2Ya/c8yLtOkr58/FXCMuivFXs
         9JcmvsXWjj52Nu3gHhqzuiX5oCMMvSl7fiA1YkDtFhojZcVG2xKbBEbDd+wBukvsUvHk
         bF3nfhNlMUC0SAWHnt4tLN6sFty6pPFCOjVcke+u544ABI95gSAoMJHeePBadBayEqf8
         Q5xxh+pBiXe9VUmAI8MpRA9dnRcTmx2EX0cFR9vngueePHvyZ5tH0RpL77O9DmUcaebo
         yk7JGJ/N6ANgbG/jwNp8ObFlrGZI3g3UvY8LtQHx9CU/D4oVN5ld5vgGTdb0rvMLSWMd
         PWmw==
X-Forwarded-Encrypted: i=1; AL+hErGPgdkE986oBlGdWEFoyxM94Q/fdCRWpZHBQhXdYRACNS4YDRI6TXi4UDanZiktFMptezfAfgPIBgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L3jNq1AlOAPT+stqQNJgCGSEtQlG+YujfR4TIk/TkunA7/FKp
	QxAzKDD6FIs4kOBDGogt7cwAvvKICY+Bi4/DCDXFKZWH2uJfBJCzpd+GD10LuHicRPaO4/LOAEP
	nSvzUP4+HvsJfC2D1N0wZCv6vqrY5EcA=
X-Gm-Gg: AZFdTZcXcQGTVgQ9TE9ZzEmgx81SqBHFtcA/K73Z/WZ9dehDJXGpee43zec+8nWfRJ2
	Bt0qhMzw0ES0A6JoKyzSUdAiKwnX171KkIy/6d7mlMDVhjWNLua4XWTqcIAk0DeRiElzQrxwtOR
	KyPi6PFyGwGJxgaxs2Qg5sqKGv3pfpUCv7pme6sPDeqU4ZNqVrzdcmn8/c3lVMVUNZsFOG/M9un
	vvIKS5xZdRIaS0rIy1zAZ8n6+OeyLZLCKnF6T1mOSEXdoWAdNxtWkKapk5BcwtOtuFG0aCx6g92
	jFvraAD04tKGGnQerrf2bGF5FgT95wFoctq7ELydqM8w47ofEHKo3KZBAOj3BBqAOM6glSpqYQd
	KVzg5vkGih+VyQDoE7Mbtx7kPsWenDriy3kQW
X-Received: by 2002:a05:7023:a41:b0:1b2:67f9:43cb with SMTP id
 a92af1059eb24-1b5525e786cmr12124036c88.17.1795416037296; Sun, 22 Nov 2026
 22:40:37 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120210317.184756-1-kapoorarnav43@gmail.com> <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
In-Reply-To: <179526830578.567.7445109567862298713@viennaoffh.gmail.com>
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Date: Mon, 23 Nov 2026 12:10:25 +0530
X-Gm-Features: Aa3M54pKXHh6UQF7oq3WN8ub3J8erT3GSETIT8vxp_X3pViFXm3_QiDK3Y4XRHU
Message-ID: <CAJi8Lv-orD3VA1NJ71L1Qcw6=AWuBZesVFOHe5Y+bwzWxT8KRg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
To: Zheng Shuhao <viennaoffh@gmail.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jonathan Cameron <jic23@kernel.org>, 
	Lee Jones <lee@kernel.org>, Heiko Stuebner <heiko@sntech.de>, linux-input@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zheng,

I'm fine with merging the fixes into a single version. I've just now
read the other mail thread.
If you can, please send the v3; else let me know and i'll do it.

Thanks,
Ayaan



On Sat, Nov 21, 2026 at 7:08=E2=80=AFPM Zheng Shuhao <viennaoffh@gmail.com>=
 wrote:
>
> Hi Ayaan,
>
> Hmm, I overlooked the latest discussion, which caused some overlap betwee=
n our patches. Sorry for the confusion.
>
> We can merge the fixes into a single version or find another compromise. =
Either way works for me.
>
> Thanks,
> Zheng
