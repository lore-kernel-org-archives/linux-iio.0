Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824004;
	b=JuVUzn4OD2pu3lmMZkksb+R3sv0dZ10lVZx+uqln/WKPYvnrX4msT39+7RHUkD+YhHgb
	 YNc4Gr2QO7iRA5MgWoYjHTOgKhW88M29FFMjYoZN5oaJXF2GHRqN+KcZ+PUT/CsY/d5Gf
	 vCa5C3soN28yi34738nZNp3aHoy7+M70li4ex/2NJiy82zi6d74vTypHoEdF0RBZDZmLv
	 zY8lfPyd1HF8C9aIrOxDYRletmyMU8IoSd3pPin4oNv/CyiOD6zVLGw3+xEZ9NdTMagpu
	 Aq1azGrr6YqpRdwcmkeRNnBJW4vJAcR8UEW+273EmbqL1FcUTUuuf8FKdW7OcEld6xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824004;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=SJqlZUMi4mTvpiqmlF5foK7DBZyPnlP1pzywr9ZuMTU=;
	b=HAsm0eB5p1tZoWQjxcOG7sfl7fM8tJHqvShhVqXGE37kjaLIuHddG4asRaS8fWusDS9+
	 AJxW3aBGURNJDTuV/6wMQG2Pl6sZbzqa7pJy9PY5U6v8eZ7aR1XYDacHCi+skrpk7evkB
	 QtKDIfZMAuCoOjGGkuSdCb4NKBHjOAatvI2YivSOv0NeGw3J2U0GvghkXI+mBoFhWPr2C
	 hGaR+Lt7kCIYi9IJD3tjPGoAAyRT3FFLTNfBOq9sOWjFXDkZdBUbsO+bqD+1UIAMUUSFt
	 nlUpOZIetBbIqkB1IJalh0Tl+tlLiCI247bphZy7AGMGYtxhsAzEcYtgUB8/VQyJHqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bP/Oyt3X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20899606A32C
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bP/Oyt3X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91501F000C5
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794824003;
	bh=SJqlZUMi4mTvpiqmlF5foK7DBZyPnlP1pzywr9ZuMTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bP/Oyt3XHLVeklt0TtxLW/1T/CtdWqVfDIheAJGtIOgCNZ4Z5E0SDM3J5HSkkfptU
	 8zRsUnYLmIWqS50luVwgx0o4A8g1wlzGbTFqbpr/nDFnnR9Mf/dIKW4YE6QWQqxV5b
	 JbptnxtmhvXGZUstSGXghGREaNJzWEiYslR03RU3wr8uBZLnE6vagiR74o5KCG/Jel
	 0/cI8X8ivU7o0zbpOSDZsQJTgIm3k1GrJ1fLLHtLuXb2NKEzuxbxXfin6I2zLb0M6u
	 RT5LlkGL2K/fxojnLV93WBvBZmlwQc4hPfYx18kqXw4b+hYAccqmliO2AZy8aOa8HF
	 UKuWoIxXIP0IA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c151178f0cso3098495e87.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 02:13:23 -0800 (PST)
X-Gm-Message-State: APuU4Z+cAO2fEf46IBUbmYQ8ngt6+8r/5tzjBOh3Wz2cN9KgZo4uZUpK
	0Fc1NTmDlWb0q7W8UyadaYmT+htTv4LPJUrs3WzR2nJe+kj0wJOcN0Y09RdO7sC9CBozQQva4HE
	GKfjQ8Z8qZCqcNQP9ts9scVrZmelmt+E=
X-Received: by 2002:a05:6512:b1b:b0:5bf:b7d2:c7d3 with SMTP id
 2adb3069b0e04-5c170b51016mr2856791e87.39.1794824002564; Mon, 16 Nov 2026
 02:13:22 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116014823.3132576-1-jic23@kernel.org> <20261116014823.3132576-15-jic23@kernel.org>
In-Reply-To: <20261116014823.3132576-15-jic23@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 16 Nov 2026 11:13:09 +0100
X-Gmail-Original-Message-ID: <CAD++jLnowMOL8ocZwYJe+ZhVFWFA0RGHVcx7AQJRYz5okdpjJQ@mail.gmail.com>
X-Gm-Features: Aa3M54olxlOrJTw4ezYb1O0T-yaijVkbM6ru0n9yjK_DqXWDbLCO-yBDZivhOMg
Message-ID: <CAD++jLnowMOL8ocZwYJe+ZhVFWFA0RGHVcx7AQJRYz5okdpjJQ@mail.gmail.com>
Subject: Re: [PATCH 14/35] iio: accel: bma400: use default_trigger
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	Martin Tuma <martin.tuma@digiteqautomotive.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	Gustavo Silva <gustavograzs@gmail.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, 
	Ramona Alexandra Nechita <ramona.nechita@analog.com>, Tomislav Denis <tomislav.denis@avl.com>, 
	Jorge Marques <jorge.marques@analog.com>, Petre Rodan <petre.rodan@subdimension.ro>, 
	Dan Robertson <dan@dlrobertson.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, 
	Gwendal Grignou <gwendal@chromium.org>, Maxwell Doose <maxwell@maxwelld.cc>, 
	Tomasz Duszynski <tduszyns@gmail.com>, Esben Haabendal <esben@geanix.com>, 
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>, Jiri Kosina <jikos@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Vasileios Amoiridis <vassilisamir@gmail.com>, Abhash Jha <abhashkumarjha123@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Nishant Malpani <nish.malpani25@gmail.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 2:50=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>
> Set indio_dev->default_trigger rather than taking a reference to the
> trigger in probe(). The IIO core now takes the reference during
> iio_device_register(), so it is not leaked if probe() fails after
> the trigger is set up. Whilst this closes a potential leak, it
> also makes the ordering going forwards a lot less fragile.
>
> Fixes: ffe0ab6a9698 ("iio: accel: bma400: Add triggered buffer support")
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
