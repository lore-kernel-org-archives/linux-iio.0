Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F3F3DE424
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221113; cv=none; b=Kh2Lha2nxPt0BDitDlSblrtX4/GHJvb3lYwcXZPwhr0Ru2iYQf2WYxe/A0ijnHZHLlFiqHATPh5ibDxBOKVhqRlqyMrixSbl/ctQm9OHgoxhoc390FpKfg54LACsUpI0r0nxCK/VsqnuBhIU8Y0UejVfKup9B5qPBtRJ6OEFId0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221113; c=relaxed/simple;
	bh=01GKf65j/jScrwoKQ+C2Gxr6oYYNcBqF+y3kaUEjbLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L2Xyc/I9hTRF5wm7cBifkxgbBbgoxqjDoN8E0NxtcE+OCgSWxeIThV7eHOhYluLjaXuIrv2AdfB9CEydEWhEaybMTG8OQLgcj9+mofMQcIFTPvSFJci5rvrZviPRefbz+T1+F4O2TjISAnY5VIu6Ddnq4IyJUJSO9LaPXl0tzfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IK9qaKAc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IK9qaKAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBD0C2BCC4
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773221113;
	bh=01GKf65j/jScrwoKQ+C2Gxr6oYYNcBqF+y3kaUEjbLo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IK9qaKAc40x9w1tTnDGK/5LfwtlPgFMQbzLlkR8KIJgzQd5uLNQvBbpMt2vh78Hdf
	 uGFIdbEEKhpLM7kwrYSqd/d6UMtbhBEQn6P8nswxyoNEodBRhoszprfEvS+TvD881+
	 KFaoGOWRRavp+r/ljv2ths/HESZBtfyYFBrTiWerLSWzV1GJ6IEITEuhK9bbwbRQrm
	 JSrEUBKRCmA4D7VowIA5CT+EyZhNq2ZFR6u9nqkXA7vxtLKcSniNmqjqfUsh5kdNp3
	 Yb95HaLUCp2J00ygi8cr6kBVXzHmTqlWtuqzhw9aLMoq9bG1iIIGd1/ZYY7er6CZid
	 6upOZohwnPaqA==
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79801df3e42so10677987b3.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:25:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXx5GK+QVEZrAJdFefuurRw2/padc/sebXSuPq5SHHdsX18OsFt8r8Sb5/1vrlf9ZZlqaI96vap4LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX+8Qz3eMDuwgWrO/vDA5B2rdZC4Bf7NocHT4jb5JhNR+yf4nM
	W9c+xQ50C9+uJQf5ah9D3riPr7MdN/EtEkXWwQb5t2gkLBKTk2x3NTdr02HvjTOSjMMVWtMfTcN
	pwslytk3jyWgEJL8KOL26jBYc6HxXb4c=
X-Received: by 2002:a05:690c:6d84:b0:794:f400:2bfb with SMTP id
 00721157ae682-79917f593b5mr14822137b3.26.1773221111798; Wed, 11 Mar 2026
 02:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310075539.11701-1-wsa+renesas@sang-engineering.com> <20260310075539.11701-16-wsa+renesas@sang-engineering.com>
In-Reply-To: <20260310075539.11701-16-wsa+renesas@sang-engineering.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 11 Mar 2026 10:24:59 +0100
X-Gmail-Original-Message-ID: <CAD++jLkoWCcBvB4G-2EDYU4kezPhVF6943TY6PmK5ooGwruLzA@mail.gmail.com>
X-Gm-Features: AaiRm52-5ccgCpLSKuxxaehFi73jWhXjY0Lv_AX860GJVRZU0Kw14nXERH-rf2Y
Message-ID: <CAD++jLkoWCcBvB4G-2EDYU4kezPhVF6943TY6PmK5ooGwruLzA@mail.gmail.com>
Subject: Re: [PATCH v4 15/15] hwspinlock/treewide: refactor consumer.h from
 public header
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Lee Jones <lee@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Thomas Gleixner <tglx@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Arnd Bergmann <arnd@arndb.de>, Srinivas Kandagatla <srini@kernel.org>, 
	Antonio Borneo <antonio.borneo@foss.st.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-remoteproc@vger.kernel.org, linux-doc@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-iio@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 8:56=E2=80=AFAM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> Factor out the entries only needed for consumers from the generic public
> header. This allows for a clean separation between providers and
> consumers. Also remove contact field in favor of MAINTAINERS entries.
> Fix the users, too.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com> # for IIO
> Acked-by: Lee Jones <lee@kernel.org> # for MFD

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
