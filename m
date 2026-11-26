Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693559;
	b=lR3ECvNhff4nIHYtDwkncPasQ+Z3QxOFoBL8tEehRG+67aJ+IfXzpaIi565rTYSF3MKu
	 YLRdpvnmoU1V9UTDpkrj0q4WvMT9dIVyOEUVQdjmuQ5rOeZ1vIlUcsgLPf4VDYusUJw4g
	 oyEyknHE7daab+MO3rMgsZuxKRRkkYk57MhiUstJUAmSbdwWFbSH+by6o0MD59oM+0pvj
	 MHKVyj7nusvQFdonLYGzRRPCnv4Htfc6aR5viYJfGTEZNIV98f0Don2nkUn3FNhkKbQlg
	 yE6tDtQG2V17leOaat1OAjU3hkVblrRbfI6PVY/n6hv9XYYk4Uy2DjJhrpZIY6at4hA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
	b=LyIspUB/DrRHwLVi/F43Kea2Xx51k6svN73RE5cMBwaw7HABhqNb0BtE3mQolql2geKp
	 M/O9pgqOXu/p8bexrrPtfg1eZeBhzOaq3EP7qugKFpsohf9gNAZWZWo4Em5IYivn0Q567
	 eKB8VEyMlFU3aFKoo/NXj0Y/DjxgYelVbh0edGtfVEN1gB4OjUr/3efZdduV9WJSj33eO
	 LFyUit83mY65h3L0xJLLZ4PAF+X3HgZMT7Ylapf55GEBDos5LXVfThQLvDjQtDEjK+IUR
	 FjXmx6RjTCfkworwNkhax5kMzlccKzZPh9/Gwy3mGm/NJ89h8e2tKv/7BSEEqhhq+PA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MjnbXg6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783AE606A329
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 11:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 783AE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MjnbXg6o
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so1153929566b.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 03:45:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795693558; cv=none;
        d=google.com; s=arc-20260327;
        b=gz7KjG46tUExXNf5fBYknFjV1oU8ZMvUHZzX1P2p1kY8dNMQ+QNS+FcdEs9wJizwuA
         4sU9oOMA2whVr/SkdRdB1lO8z6vtUQ38gr2h216PVHa4Xe2kyiz3T7vEPw6ADZ1dzocC
         drL6VY3dj6DdkpHEx1Te1znVAMFhoMilvmRe20uZ+MKrgE3hFAKVXguoaYnKNUER4+KH
         IA/SD2MCP8uSCW23s95HB6WBjxwRZ0ihb4OGPrCvi7ANiKBv7H47/o0jNiDDiDKKePAg
         TnJrfe49VDwcIAF8pC1+Gjpz2jW8QAi3kzSzqdixm6VO5QPzEonRAXujquBTvY/dzjZB
         Tpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
        fh=vT7BtNThyXzHdVUQ8C+OwC9uASqifTDTTzBrf2ErNkQ=;
        b=R8b5a4tncxLSJab4U2up8wWwBwTdk7TuRqMHmr7mTVruwRNkZXEwFddFHXijpTCpf6
         9HLfMgDehQZGe+eeB2Yb4VzHr6PPXN5IGp0Ew/DEHORFUlwQ0rbhO+5FtdxzD1F4HYo7
         bgY3g9YuWLgXhNFdROD83vrt9S9Hc83oEDVsL13XDADK2IYsbE4CP+jEyM5vvzx8KvYt
         CJt45AvZ1ST5ptoI72Oog3aekz0JFMA7IyTzwVX4+WwDcoAwUuIW9UT0EYmQ/UgErgqF
         +PPlnGH3JVrPR28eRhc1tSEzdpYV5STLDrE/UqCQDn50GBtWZlptbTCm0i/W/Qtw5KQ5
         +3/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795693558; x=1796298358; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
        b=MjnbXg6oubXtXF4GY3n6Ri5wN3VjErZ440rJoOeW/FZXxlLziYjCa4zwOuzVOB/nM7
         kxDEQqXK5mGAAmvSrTNNMya2J9/qUJliW7Kq2H0el3Z30EEyWCXdcgpRU8TGeVQ8+68r
         RO1es397Vh73f82VTxxEh9PLH6ii2fkNzbtnp6na+zBypER3q8Mc/gruiXSmExGh+Mfy
         8ym4h9wJf0JSPuljojTsIYmmtnC7K6SLxBkJRLo5+r8KIpCXVuym419RANN7BmeNgJk4
         qUw0UepBK61we9Ih9TJMsCa1vvZ8PiPQ0wt/Q8x4NL2px1sTpsqJYpvCzsbn4BZlWK16
         B21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795693558; x=1796298358;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KhpuoXVxsmipcY+EIJDYgZSdqvKp313n7f7r77OAm5A=;
        b=pAM+jgSc5tOf38j9pkHuxlrD8SV3VFdBGDlK8YpwP3zGWubfoxUGNFqBC5oU0o7O4n
         jjoBz7R3cv4YbhLQ6PKa9K5JObf48cTQImWyjYJqsvP9lIfcoZRPzlvaufwW1JHRLhWT
         CVbsGDXk/AgBpsmMo+qeJj3ZAXRnePulH/+VH+FLpkw4At6iO9T8+//lQ7bUJfCjbvrQ
         Pv0Yit1c+a7dfMWsZyj8IrJFNWNJQU9YA+wLRmpbDI381X4fXyEwAyBS+OYYWScGiQVn
         7LJzS5OBFD1rN7rlspvMF9mjQCesKHxuBHwlyARpQTXZZ6YVg4J7EgT38DZcRVIXfRZ2
         9+Qg==
X-Forwarded-Encrypted: i=1; AL+hErFcvmR0HjmQfTaWfKiPJH+UkNnX88UZS2WAH9cmDyHqsaNYKD7CsqIP+iK8FegOXTfIzB3QKT1F9a8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ssl9EFEHrEeJ1FWK9lENSDXj9fB3JRCeN2EQccClRLz+NBu5x
	QJBN3S8tz4GjO8eYObSv697/zqkS4uWe0KcMpm5MTd6oJc1TSkvdx4JYFZIJrHESrb2Oy9S2iwS
	caY6PiFY0WROCyTLUJFWnulVW5GjCzuA=
X-Gm-Gg: AZFdTZc+qpMB21H3Kj+M4jdcpMH6MoJignifynrpwhzi2KwM3XkB2Telup2GfmQ55UY
	0IRhFfxnV3+UwvWuY/DXLkAiOMk4+DL98jXJiLda+PyaTrd/VqRgICXMo3kNh5A9WnYRb7urG5G
	mhDx+noGRQI1MiBky2btQt8TwE6XGGqvJGoEOyTFihWFzVn+VgoJ+O0opWrbEA6gQ3VUbJs65ZX
	WWAezVwQGPm8QZA+ma9shhLF1gOHX3LouDBjLxxf6vfN5/q2EqXrWl1U8+pcSLWHQmoAp9YkYES
	0LXnG6HRk/+D+32EX3AbwEaXwAsq7WvwwtTn4zcLfOt18o5ODgeRvogc3h9ASF2FoSd/kYaokMC
	t+2RPajZSbcT47Ve3MPgjP9ik3qmVCvn0Bd/GJT59Bm+2AfxLA6wfHu4RIvVfJZXeQvw2lnIsEp
	ihShDf2WsdeKm3j4c//Gi8VT9Sdt/ym7OcvNrM5G26M8wNMTBudvzA5fHdKA==
X-Received: by 2002:a17:907:940a:b0:c50:94be:22ab with SMTP id
 a640c23a62f3a-c513a805245mr1958182366b.18.1795693557771; Thu, 26 Nov 2026
 03:45:57 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126081155.501493-1-wenst@chromium.org> <20261126081155.501493-2-wenst@chromium.org>
In-Reply-To: <20261126081155.501493-2-wenst@chromium.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 26 Nov 2026 11:45:31 +0000
X-Gm-Features: Aa3M54ply6HBL37GF18a3MYmohyvcmh2WIoJZK4wXqF_bZ1XD2F1MsOFc3J2ofg
Message-ID: <CA+V-a8tqzDTbMu5375vub=DBHmpJWW2TvUGKfsuPf_gjpSuC=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] power: sequencing: Allow desc=NULL in
 enable/disable stub functions
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 8:12=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> w=
rote:
>
> The non-stub versions of pwrseq_{enable,disable}() are no-ops when
> the descriptor is NULL; however the stub versions always return -ENOSYS.
>
> This would require more code to deal with on the consumer side if the
> power sequencer is only needed for a subset of the supported devices.
> One such example is the rzt2h_adc driver. Only one of its two supported
> hardware blocks requires a power sequencer. The driver could be built
> without power sequencing support and the other supported hardware block
> would still work (provided the Kconfig dependencies are changed).
>
> Align the pwrseq_{enable,disable}() stub functions so that they also
> return success on NULL descriptors, acting as no-ops like their non-stub
> counterparts.
>
> Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Added blank lines before return statements (Bartosz)
> - Collected Biju's Reviewed-by tag
> ---
>  include/linux/pwrseq/consumer.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/include/linux/pwrseq/consumer.h b/include/linux/pwrseq/consu=
mer.h
> index b69117ad3fa7..d3f5f37603d6 100644
> --- a/include/linux/pwrseq/consumer.h
> +++ b/include/linux/pwrseq/consumer.h
> @@ -47,11 +47,17 @@ devm_pwrseq_get(struct device *dev, const char *targe=
t)
>
>  static inline int pwrseq_enable(struct pwrseq_desc *desc)
>  {
> +       if (!desc)
> +               return 0;
> +
>         return -ENOSYS;
>  }
>
>  static inline int pwrseq_disable(struct pwrseq_desc *desc)
>  {
> +       if (!desc)
> +               return 0;
> +
>         return -ENOSYS;
>  }
>
> --
> 2.56.1.839.g22a8290db9-goog
>
>
