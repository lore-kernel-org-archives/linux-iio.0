Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794557847;
	b=ZL2eNEXi0sTSCBULW2REpTZPYdNqJj4ItNexJrlxr1nz9Vhar0t4Wml/FdrxY3Vp/fSh
	 d6LKIJNkUOBaAMCBNZOz3ldMGILiXUlgY+T5NH/aVGK0egkBxsufTgOwsiSfGLk/3uzMU
	 UflxeKnlvK5X10Ej5akHE7NptaemCU5GPhjjXwiTEy9CCwIh5Z9+Al+b78cI5sUDfkvJ1
	 1C25yEEQeEKjsWmJGPrUOf7ekTji9rideemwthdsSY/KI/miP3wMIfD3tYjYRqUlYaoJh
	 HzwBaNTLKzhoLVO3fgYCUFOxMhgG/anjL/PZFQpjo2ip6arswRJwwZ7wF4TMD/6hOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i9YncqY8Myt/AnoV6KAesBM+DBBngfLDYIytLg96Euo=;
	b=1aiyYKoF/HAUYmYiFIOsEhMVMcWrtLL9Tl+3Rrhwj8dBB3QNFBgPQW9kbC2NwzabBpoQ
	 0RTvq+kzX783uEBJvL6fpdgsuH6QJq8+X1YMONvEosX/OkBBhxqa0W8dGTaSPAbhpvaHZ
	 dxM+VUoo10wAvYJGWFkXb4MMcfZpc8pcnwfENvH7z7zsfTjB4jLcTFRx8of0jerNaCKIg
	 Qw17vTAyUh9xGSnvnm8nuVmeczPFjQBwPUBm5nw/BPzBrmN3g7w2dEoEkyiV5CSO/RNfG
	 qOXxtLoRGYp+3vvtBUew+THZtOEnA0rUca6gEHWe9HesPf6ZH41zc704lr1IsWIWVxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k10CgQrD;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC4D606A32E
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 08:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DC4D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k10CgQrD
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so1424712eec.0
        for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 00:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794557846; x=1795162646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i9YncqY8Myt/AnoV6KAesBM+DBBngfLDYIytLg96Euo=;
        b=k10CgQrDYczHjcgUWWa3CxLpyv2pLiCJJ9HVt4SXQb/Bde0Tawc+d9tsZkIoAV71Th
         GED58T8JTP4yb5aeqIjOKsJEDY2QMGMoU3oABtybqHIgoyvhW8egh++NNa5dg+zT2mVb
         w1lUX5F3YpPVr5qjwGGehjFLpqMjl9UBtg0VJauKYi4jsaEuRYbnh9zQpnb6zIr4LQmi
         aVFVW4N+aEDsS8fqr4GVta4m+Xjt6SKblnA5YpyGdX/1zBjhwH4+vvCb80fapDI43W87
         ImJ5a8Zb7rcZvot8LC8/crn1UgrDXEDzP7BPhKR5zQxJ2bO9sO43f+jd2qCbqDdc824P
         euJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794557846; x=1795162646;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i9YncqY8Myt/AnoV6KAesBM+DBBngfLDYIytLg96Euo=;
        b=weHikRXhbx9HWrBV1qVtm8BLdl+8FUpK1OD9uAErK5G+CwOCIFQYqtgLzTtxeYGEY+
         pF670MsBuCWiZkDi0bufnUjbrFhqWD0gdH6EwiGmcnesRsVbIzdzwIgt78Hze+kNf9l3
         grKN/AdUZH1irZkSvzlBGX2sa+QuW10TFMAHBboqpXOCEuCxJnOSDjkWd9k+bxNzyH0Y
         2AzEufsbNOoLNv5qmEcGU48EwEdGosdcouvTOjqAFDqbJDcEizxbsUqRoVRAuCPi1DSD
         XO8LygduvyBQiMPqZJFk0Noo5ZIpQ83B5GccZO6TjRZfSRn4fbOG8N0o5UAp3Dov91k6
         0QMA==
X-Forwarded-Encrypted: i=1; AL+hErHIeT1WGAmVsMVUa8ycP4Uq7jVRodSyhraCXxRoBu+9GQM8rDeV0qmrMNYjWwBUuBCemu+W6+oDpJs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+v8Njx9zLspVydaWE8v/n8t5dQba3CR0kghufWUbpF6lHyHKJB
	3+1lqOJAV4vRBXiYw8oF6AkLIV4YiFjcrubmP4/y7dlyIUEmsJuB583g
X-Gm-Gg: AYBFou3DHgEKcYqFohzNp6q0yo83rn2IllNYcTM/8VPWSchVtpXOrrfUfFdqrA495Ej
	O7ynP73Z4rQASQtF+wS/SZQJuIoJ8l5DnJ0By4nk1vXMtmNy1mFNOxw8AyMpYLiInW2JkFAOtIL
	VMNiEFqhSvXwctbxkTppJfRYcxKXn3tOhvtGnW0jv8i6lu8uXzVq1lzYF5PstcnMqWJ59o4oSaY
	PBc1H2TotAQmscF5ht4Pv3BOT4uXNpQ9ZqUOrrFaDUN2bru/CF1Z3ptF42hOc9uDt0OwmQHc5ls
	MsgWf/8aDnT3X5XGfNfAfBXPnGgRkgI22eO+M1q4nifBAWOL9JGGWTPs47Q20oIQM3ie4ablgqh
	S6yZnO2hwAnNxFD5DU/Gu4enzJDx+niWhbTOJmM20WmCYSjycYNpmHpAc1qmIrP9bAjHdi3sPoW
	syNKuBISRu4hGvtnYx94gOjlhF3sOMRBcg10PgJBgzeBE11iQ8H1dYiknjekcU2+N+S5JgK+Mue
	V4XdZ1HRmjrqcmMwizVdg/r7/3ue4kd7cWEc0jlqbrFZG4yNX4evXjTAJCc5I+Yleaceiku6VFi
	2+xlslbVT9fjCViuQTtzWC1l52Vbyq+VhKQVsduQIQl+Q8pEkDzYQTHwuex56XRBQ0jPdTGSNmV
	HsFrjhWHdunwq+qg3wQ6B7sA7Z0BQprJinhs/WBrXmTPPtf3gGiIDSxxtA8h5Y6gJSaJzo4pHZC
	1Uxceo+uvcA4M5vGjAfBABCEGYdzcb6lsayG/Od4Re5A==
X-Received: by 2002:a05:7301:5f0b:b0:378:7434:a526 with SMTP id 5a478bee46e88-3796628f413mr1531760eec.14.1794557845941;
        Fri, 13 Nov 2026 00:17:25 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795533170csm5403337eec.7.2026.11.13.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:17:25 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: =?utf-8?q?Oscar_Alejandro_S=C3=A1nchez_Lucero?= <aleszlucero@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: fix kernel-doc warnings in public headers
Date: Fri, 13 Nov 2026 13:47:19 +0530
Message-ID: <20261113081719.10678-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
References: <20261112-iio-kernel-doc-v1-0-e382fc9a47c2@gmail.com>
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

On Thu, Nov 12, 2026 at 11:25:31PM -0600, Oscar Alejandro Sánchez Lucero wrote:
> Fix two kernel-doc warnings in public IIO headers:
> - Rename @consumer_channel to @name in fwnode_iio_channel_get_by_name().
> - Replace repeated 'NOTE:' labels in struct iio_itime_sel_mul to avoid
>   a duplicate section name warning.

Reviewed-by: Arnav Kapoor <kapoorarnav43@gmail.com>
