Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516533;
	b=UbYmpTDmkZXJ3IX9rjnxkQRyLe2kQvaQka28WH8s3r6xL/wAfUePpqD37zKiqPI5nbbm
	 FP/akEGCI5jtt4ydMSeFg5hET8MuBXsqeuJV+uJkKIiJm7Z20qjDQBTuRG45cL/pFluT5
	 b4eH5cFBxzTNCFZAaNxbOY0fFr4kz50xe2VfXl3KOC6VjfQrbYc8Mf2ya5WkN3WBrT3bG
	 9bH5EoEGuvlNGWjonw2CVl8eeYuC3bQSP2j0uFDADYEZ2Xg46/WJ7KVXRiLCbRqEM8g4F
	 mFlIhG/XB/Vw7oXtBrKbCxq77ngOGqGdaZJwZNLn8mB2ttzqrQeXZsB5Fo+qY0JF/Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516533;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=+7AvEO87agVesSj9EpGksF6DuYMEbv0EchchTnG8b/k=;
	b=nQhz76HDdbqG3AFissJ8yOl7/kIu7Vhqk7wE0nhcfc20d2xEAL2sQOGowP5MHjwhWjUk
	 66xthV+J7haIBvCPc77tosnijW0lz2Xm6EA+zhSa5Mv7hiDHEhnnmuyn0gx94nGpwuzUF
	 HeSpecCwU39sJpy4jkkDTiPJgHPYQb6pkas5dKonajADHgHctRayJzVpJi4b6kgemVx1e
	 fZxsy4jdtalessrlpRGqsB6iZ19iWTNGsfW5NPq4JJ5Fg1zQYJlN9ljHf80o0Q5QHjxqL
	 D4lXd4/sGXLVBpEP05Ew/MgjI9WZuOoxTlvuzTpDztKKXYVwVD5MXryqbAztPLh4GCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C12606A320
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:15:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF781F000CE
	for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 17:15:32 +0000 (UTC)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5be416e603cso448025e87.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Oct 2026 10:15:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwji/KjNwrIzxVLciALAoHL3/ScMd4kPbq0eInleoldA4ASjNRGvzFy9lR7CqNCgmmmBPZATu8WAlI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/8UQI3MKu2+xr78bjVJU86VQT1uxxNa/hfleDcd4JjvCOfspr
	uTb96BfaYqlN1uANJsmilP2lkHFzj33WUkwdPL9IhJhmDOQ8R19NLYVRcxRXoon1IPXjRb7MPtI
	W4lpuNm3ONR0OkCSPAtTY8cY7WxykLEc=
X-Received: by 2002:a05:6512:33cc:b0:5bc:b0f3:8a4e with SMTP id
 2adb3069b0e04-5be50a62a31mr3833052e87.43.1792516501664; Tue, 20 Oct 2026
 10:15:01 -0700 (PDT)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020-iio-light-gp2ap002-v3-0-b7e0946c9e79@rudorff.com> <20261020-iio-light-gp2ap002-v3-1-b7e0946c9e79@rudorff.com>
In-Reply-To: <20261020-iio-light-gp2ap002-v3-1-b7e0946c9e79@rudorff.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 20 Oct 2026 19:14:49 +0200
X-Gmail-Original-Message-ID: <CAD++jLmA_CAJi31OJe19A1H316XfigAKy5XbGcpvj1CYzPYY2A@mail.gmail.com>
X-Gm-Features: AclHuK9Cj5HfENDrz3fDPSLBKmxyGLPpayybWidXDJBEn6zBCvvY9bndZC-YM6k
Message-ID: <CAD++jLmA_CAJi31OJe19A1H316XfigAKy5XbGcpvj1CYzPYY2A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: light: gp2ap002: add leda power supply
To: Christoph Rudorff <chris@rudorff.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 1:36=E2=80=AFPM Christoph Rudorff <chris@rudorff.co=
m> wrote:

> According to datasheet page 8 "Recommended external circuit",
> it has tree pins that need power: vio, vdd and leda ("vled" !)
>
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>

Looking good!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
