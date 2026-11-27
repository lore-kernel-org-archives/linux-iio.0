Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772883;
	b=GK4+HSkv1+agxsHLiP8mpAcG5lGD72+tj0mwG9pyjUqUX3MUiuhrgY/fHzYuEXj9JjfD
	 XQveJRUWZtWt5KEkaC2ec2yq6yXMMBTXB7ve/++TI1vi+MJv4LE5SnJJCPTF6AWWkakAD
	 RwDgPWKWMx3AWXBmiRHF1LJBSwo2vimt3qC3M/uoSRyVRptKw6VieQNrk2Q6Hu9qQFmhH
	 pgkYCwSr1taWjn4zsX3pQV+AcK994BBmnttzHJhtjFgeoxo/vDE09V/bQIIwCZq0vssu0
	 SnvPiOJSA+8UFUyYpawPzWMn4QDUNRiY8cW5G5PPjlmAMGDjhTrXcMvMKVICszrnmnw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772883;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Tc742TYfJhDQmrqXP6y4CVcIqWZqN3Pcpffs/yYZ5HQ=;
	b=tNGwIwYv1uiYgmE4KQfRcAobx/Uc/wS2Sfmad8mA+T0qtpCjqWPo4Vz/aYv399PeEIp5
	 aUQLviZuNIGsJB5Ac1IE85U9nM7C0WRE1Rki0phjRn+ucHY9uMqw+yHZud7yFLjYd1Vyx
	 EZ/ApK76CLDwmmA8M/aNL+aL9tSAJ4CtQtQXpVDLMjjIGLM2jk5VdX38ZpS6b0x/BYJyG
	 JNqWeqJo8qf4qPF7K97jZp/JVpYHW/Zcb8j5NMHxyV6lOcFuQI5OddlSGO2uakVf9IeK3
	 SJP6Of4K6IJg8OUKoTBNZgms454QmqYJsQLPQY+eyagRSQnXorNHXO/Ixm9xucQQLbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2AvpS2+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC54606A337;
	Fri, 27 Nov 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C2AvpS2+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795772883;
	b=XOAYL9XaiiB5LR6sAVF7g/bG1tGFT+vaMQZVGmICKkWICK8b34YUW+SrSaMIYACnGE36
	 dPy3SxI7YOS5VdBVP1FjZH8xl1KY3/kuWpzkIRe+R/ZB9FaAzX05y54Lo5HCex9jprrmH
	 bn5cyMMqTt+cd0eKpV014Q0akfMTqplKhPEwgokfGQVxED2131Dh06WWSvkcGgdmZvOMv
	 k4nSfR76Vr7YuLhqzNghYm3Ds7wkc/Ha/R7RSWvPWlXrIVaTnhU4R1CvFGCliBQ1EAsuc
	 tmuLVx5dOGpkRhnX07F19qtSOigM6oDWuM5DT4iI/ITk/mrA7O/gy932MkFoOvFv3AQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795772883;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Tc742TYfJhDQmrqXP6y4CVcIqWZqN3Pcpffs/yYZ5HQ=;
	b=vXTQebujZ1GCZsF/mr5S/FAhtehBxTuQqQftOEpAV0QWX2NCYD5fzK4xPSVIz6rRqv6B
	 FpnejRFTe7laTavIJvfpA5bF/LqtVNucgoaAhfjbk+9+Lqn3TCfhUlE5R0ug+CnJK1lfd
	 Vdsb/jPKt7lyuLftwUxs1rYgeAtNGl63pUc0eyR9K+wTF1Y8m5rtqtx/+Wwyij3wrn7dO
	 VwrlqbrbciE/4j/xLw24/TB68O7FjbNULPxfvXekKjskBCedZA5i+zhGYv784RyueTdPQ
	 98iQEAU+ddQmSipRBdbA5nYMqSlmYkz4rKw23AfH2LlNsTqGl+hL495cxsKhocXWBsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B5D461F00897;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795772883;
	bh=Tc742TYfJhDQmrqXP6y4CVcIqWZqN3Pcpffs/yYZ5HQ=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=C2AvpS2+GEnGWed7z1AzSjhWZsXCYEA2Ar/63GiuGLhweFYKK6+klUZLDFS7hUWGv
	 MCkVenLaxuYrqHPteNGFhckvvpKlPcV9/hH1oohEzCuuYM/hOprGu/UUHAPtdd8iaV
	 kOM/rxhjroDExICEhMjsSMY8CPHIfrIKQEUYmUSuplGaKYZGktX0Da/ryAYgF/Af0A
	 FOtjnz78xytvGdSafHfAzDexAJo3ZipMq4h7sMzv/e7OmAt85oKMF8XJuwOAEYh9c1
	 Xd3QaHdn3X1MblkFCiCcUGFlR5tzlhJQTEOmqEE66GdIyWhqAr+Op3gXSt0lLT9/NP
	 Q0xAVAK3XW/Og==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 33EFE4B6C5;
	Fri, 27 Nov 2026 09:47:56 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH v2 0/5] iio: split struct iio_dev_attr into typed core
 attributes
Date: Fri, 27 Nov 2026 09:47:43 +0000
Message-Id: <20261127-iio-core-attr-review-v2-0-e0aed1e8a81c@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAL9RCWsC/4WNQQ6CMBBFr0K6dkynRQKuvIdhUeoAY5SatqKG9
 O5SPIDLl/z33yICeaYgjsUiPM0c2E0rqF0h7GimgYAvKwslVYWoJDA7sM4TmBg9ZIVegFrpTjd
 1WfWNWNWHp57f2+25/XF4dleyMX/lxcghOv/ZujPm3Z/EjCBBHroS+xq1tupkJnNzw966u2hTS
 l91TOmJywAAAA==
X-Change-ID: 20261120-iio-core-attr-review-1323b39846f9
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795772875; l=4845;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=y9MU7THAz/8VJ3YOGLDHHKTJxiT7uNrBF8+pDARjifk=;
 b=QVHkvGdCnd7UXJFsZ9kvrlPtf6CLg9+OCT2JVBs7HRUO/myeHJBjDln/RnV8izp4LGyVdrX/b
 EcIgSnZSrj5CcuWeC+7Y65Jwj9jNGUW5fd35z1s9ctKwdqVgjDIKaKd
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

struct iio_dev_attr does three unrelated jobs: it backs the static
attributes declared by drivers through IIO_DEVICE_ATTR*(), the channel
and event attributes generated by the IIO core, and the per-buffer
attributes. Every user carries every field (l, c, buffer), whether it
needs them or not, and the meaning of @address depends on the context:
an info mask bit, an ext_info index, a scan index or, for events, the
event_spec index and the event info packed together.

This series keeps struct iio_dev_attr as what drivers use (dev_attr and
address) and moves the core-only state into private types embedding it:

  struct iio_chan_attr   - core channel attributes (channel, list node)
  struct iio_event_attr  - extends it with the event spec
  struct iio_buffer_attr - extends it with the owning buffer

Attribute creation is split into iio_chan_attr_prepare(), which builds
the full name and runs the duplicate check, and iio_chan_attr_add(),
which initializes an attribute allocated by the caller. Each context
allocates its own type and sets its own fields, so the core needs no
size, offset or context pointer.

The intended benefits are:

- Static driver attributes no longer carry the core-only fields: 32
  bytes less per IIO_DEVICE_ATTR*() on 64-bit (72 -> 40, without
  lockdep), for roughly 220 users in tree.

- Core channel attributes fit a smaller slab class: struct iio_chan_attr
  is 64 bytes on 64-bit, where struct iio_dev_attr was 72 (kmalloc-64
  instead of kmalloc-96).

- Shared attributes (info_mask_shared_by_*, shared ext_info and shared
  event info) are deduplicated before anything is allocated. Today,
  every channel after the first one allocates the attribute and its
  name, finds the duplicate and frees both again.

- Event attributes point to their struct iio_event_spec instead of
  packing (info << 16) | spec_index into the address.

- Buffer implementations no longer depend on the attribute layout to
  find their buffer: iio_attr_to_buffer() replaces
  to_iio_dev_attr(attr)->buffer.

- Context-specific attributes become an extension point instead of yet
  another field in a shared structure. The IIO backend framework is the
  obvious next user: iio_backend_ext_info_{get,set}() recover the
  backend from indio_dev->dev.parent, which, as noted there, breaks as
  soon as a frontend has more than one backend, and
  iio_backend_extend_chan_spec() refuses to combine backend ext_info with
  the frontend's own. A struct iio_backend_attr carrying its struct
  iio_backend, created through the same prepare/add steps (and so
  deduplicated against the frontend attributes), could address both
  without touching struct iio_dev_attr or struct iio_info. That is not
  part of this series.

No ABI change is intended: attribute names, modes and callbacks are
unchanged.

This series was developed with the help of an AI coding assistant
(Claude Opus 5.5, through Claude Code). Over an interactive session, it
reviewed the IIO core, discussed design alternatives, wrote the code
under my direction and helped write the commit messages. I reviewed all
of it, and the design choices are mine.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Changes in v2:
- Drop the RFC prefix.
- New patch 1: emit channel prefixes into a struct seq_buf.
- Remove each struct iio_dev_attr field in the patch where it stops being used.
- iio_buffer_wrap_attr(): use __free(kfree) and no_free_ptr().
- Link to v1: https://patch.msgid.link/20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com

To: linux-kernel@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno Sá <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>

---
Rodrigo Alencar (5):
      iio: core: emit channel prefixes into a struct seq_buf
      iio: buffer: add iio_attr_to_buffer() helper
      iio: core: add struct iio_chan_attr and split attribute creation
      iio: event: add struct iio_event_attr
      iio: buffer: add struct iio_buffer_attr

 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   2 +-
 drivers/iio/iio_core.h                             |  58 +++-
 drivers/iio/industrialio-buffer.c                  | 154 ++++++----
 drivers/iio/industrialio-core.c                    | 321 +++++++++++----------
 drivers/iio/industrialio-event.c                   |  99 +++++--
 include/linux/iio/buffer_impl.h                    |   3 +
 include/linux/iio/sysfs.h                          |   9 -
 7 files changed, 387 insertions(+), 259 deletions(-)
---
base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
change-id: 20261120-iio-core-attr-review-1323b39846f9

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


