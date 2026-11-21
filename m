Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795263826;
	b=orQQIwgVkjuyfY3LmLbVScwh8RhcpMixKVPq2gnQxsCZKKkKFVogoJ4aiFgMAwww24PE
	 Yz+dNqHazjyy4G9qYOVMMA0oNMm3/i+rqQhUmAduXqIBPkd/6bEGjCLE5sNi+zeQvEKs8
	 yuV86DiA+NawVrdvvWsiXWdj/zFmqQP6J4utXJv3+1hz7V2jpNFW4a8+xDaf4p3DuyqMc
	 OWMjQu2suyAjTQwK5K6b3thAd3BU7aXj0zWvynyMWtaAOGnk8FZJ+ke+77eCkolVTJDtW
	 I20+cNMAeku/ZH44pIYiRzA78oH9GHKN49jDaEyvaNfkkrFQEMcG0joCZS/Waqz3pfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795263826;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=0YijSrdKk8GshuLhghqOfWivDklXZHznf47MFmanwjA=;
	b=xfy1xiFQGmCbl53NkUxFRazGZutylWLkB/0kM9raW+hTPdkNpRsKiWeN4zW/+4Mzhojs
	 zS1E3ZUridtsk1K3naLix69CSbpImPfuDPf6aKv4bF3lQhDleXWBw+Ly8TlExUHSJ4OAM
	 h2AmXMx5a6+ANDjz1PqFItQi6QTZJtbdKT4ZgJTthOxJgu9wd/nzlo2BBepOBSttGpHHi
	 QFijnmiSYWQ19kWFehDPLQ1/TC95UX6MjIHFczZhiaX6C5OCNnMYqlwkFnzxHs0BVfXlf
	 CgiK5MlmcSFmYol6m6I6gzo45rvWwP1WAXDqGquaGUJsamZuJXRiW+IIKcdNG42LpTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKTkuMm0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB30606A320;
	Sat, 21 Nov 2026 12:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKTkuMm0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8E21F000C0;
	Sat, 21 Nov 2026 12:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795263826;
	bh=0YijSrdKk8GshuLhghqOfWivDklXZHznf47MFmanwjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OKTkuMm0BF+zyGss3ruGVl3agWRMdAbWem3UXr5Uj18b1xGZ0Zj1LNRkHK7Yb3d3C
	 08Lc15rb0BAVchxz97QcqD09ulfns/3JPIpXbfohtw5PerG1fFH8BybwmKzeiZ5OO6
	 YLcnQqc/UfScUWlF9AgNtjcI4nw0fIbHOVOWVC+MTXIRQbRT0yBmZ/TUhNcpci5xUf
	 JKzowGjF/sIXB3+s3L3N2J6UVKc6YuPGGoppNC2Vwo57AxVWhkSbLbOiadGaJfjnHa
	 2PaYxuXW/dG/pgDUCzSq3/1V7iT8nfUgVGhbKP0F13WITek1my+ieH5uFa+a7g5pAG
	 3RGAnEWExqBFA==
Date: Sat, 21 Nov 2026 13:23:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Adil =?utf-8?Q?H=C3=BCsrev?= Tepe <tadilhusrev@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: proximity: add Imagis ISG5320A
Message-ID: <20261121-arrogant-viridian-swift-fb8001@quoll>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
 <20261117173333.1853986-1-tadilhusrev@gmail.com>
 <20261117173333.1853986-2-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20261117173333.1853986-2-tadilhusrev@gmail.com>

On Tue, Nov 17, 2026 at 08:33:32PM +0300, Adil H=C3=BCsrev Tepe wrote:
> Add a binding for the Imagis ISG5320A capacitive SAR/grip proximity
> sensor (I2C), as fitted on the Samsung Galaxy XCover5.
>=20
> Signed-off-by: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>
> ---

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/sub=
mitting-patches.rst#L830


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

