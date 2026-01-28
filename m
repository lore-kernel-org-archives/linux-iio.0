Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE28223D7CF;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622744; cv=none; b=c1igGcMiHh1tIvEwtpfW8hL4oIjhzjKHNjH2uuuvR6FyP9NheM9qROhQOs/8cdY3lDcdxRiCGW2I+DhabieqRdLhwIFR52kl4l6aWo7/uzlzNB8fSltzX44m7tQqdgo2baYkU1fDVOMMFxYW5KmvTr7J0SoDJtUd6QrLX1BwKVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622744; c=relaxed/simple;
	bh=grudBBojUDQzSCg+YQ92Tl8bHzoXvNS45RtDFBkSH/E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X5e4EKdm6OY0IWg4fosWBAOURAwLXwHeFyPrKQzdgx4nBcWefygVBLJx8QiXybtNOIha9nO3QJsDrMM6FJoT7gYduJxrSORC+mPrhJAJoOAV2k/NTQhOVwKFu75p/CX58f1rSXhcP14ZRKdI3K/15kepxOB0/2LeIA7cnNDPOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0JvPOnh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0JvPOnh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95C46C4CEF1;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622744;
	bh=grudBBojUDQzSCg+YQ92Tl8bHzoXvNS45RtDFBkSH/E=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=E0JvPOnhJN9LFLG3NyIdU3WNS8fp1eMecA2OCyOypBUUWXybChDLIz6iL2WrXgvZC
	 0nxor1jQZ9fDp/v5G4Iajn0LlpyfuxcHP8mryxHEd7P6PeKxQZdFC3XXaIP3Aba+HW
	 AxtbG0nhIEJ+aMwP8Clm2ISo9EkorvWE0mlX7B7Gs+ngFoVw3rjoS/1lJlRj4xN6dW
	 vDXGQToZ6KnDjyG8AkR129o6j6ne2W0QJi0V01Jro5mpEFgK/vZhsLfTG9Pdfa97z5
	 9YWyr7aOhLmPyOGI5MNiI2zI1KrPgAUApQgQTMhurLEOEjNMoDGLor6Kh+RuzrtjDn
	 eQ8VqtIzyyGRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86439D46BE7;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Subject: [PATCH v8 0/6] iio: proximity: Add interrupt support for RFD77402
Date: Wed, 28 Jan 2026 23:21:47 +0530
Message-Id: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNMemkC/3XM3QqCMBjG8VuR97jFfN1XHXUfEaFu6gvpYotRi
 Pfe9EiIDp8Hfv8ZogvkIpyLGYJLFMlPeZhDAe1QT71jZPMG5Kh4iSVrBAud1VpwvCfJpDSNcWj
 aymjI6BlcR+8teL3lPVB8+fDZ+kmt799UUowz2ZyEsFxxae2lH2t6HFs/wppKes/1D9eZV053a
 IVEW+OeL8vyBcZd1GrrAAAA
X-Change-ID: 20260121-b4-rfd77402_v5-558b8e28c387
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769622737; l=3902;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=grudBBojUDQzSCg+YQ92Tl8bHzoXvNS45RtDFBkSH/E=;
 b=OdnnTjUnmJ4u8XqYPyEdU7DLO5QZjts8NO8+COAzoNiz+R+FCLL6CkBnYNQcNsQ/gyG2VbBq5
 0X2mzdEVEweBeykirCUBmCs4v990avq64fBcxty6GGeGJtWZYBV19I5
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

This series improves the RFD77402 ToF driver by cleaning up include
ordering, improving resource lifetime handling, switching to kernel
polling helpers, and adding optional interrupt-driven operation.

Changes in v8:
- Add comment for polling timeout value.
- Fix indentation for macro's.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
Changelog:

v6 to v7:
- Add new patch to align polling timeout with datasheet.
- Rename the polled value variable in rfd77402_wait_for_result().
- Fix read_poll_timeout() condition.
- Update commit message for devm_mutex_init() patch.
- Update commit message for 'Use kernel helper for result polling'
  patch.
Link to v7: 
https://lore.kernel.org/r/20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com

v5 to v6:
- Convert rfd77402_data comments to proper kernel-doc format.
- Re-order the patch sequence as suggested.
- Add missing header files.
- Refactor code to get rid of the i2c_set_clientdata() and
respective getter calls.
Link to v6:
https://lore.kernel.org/r/20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com/

v4 to v5:
- Add precursor patch to reorder includes before functional changes.
- Use devm_mutex_init() for proper lifetime management.
- Address maintainer feedback on polling helper usage.
- Remove dead code from interrupt_handler.
- Add blank line in rfd77402_wait_for_irq.
- Update measurement timeout comment.
- Add helper function for result polling.
- Fix comment format in rfd77402_init.
- Remove 'data->irq_en = false', as it already initialized by kzalloc.
- Improve documentation of private driver data.
Link to v4: https://lore.kernel.org/all/20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com/

v3 to v4:
- No code change.
Link to v3: https://lore.kernel.org/all/20251221083902.134098-1-raskar.shree97@gmail.com/

v2 to v3:
- Add 'Reviewed-by' tag to dt-binding patch.
- Update commit message in OF device ID patch.
- Update commit message in the third patch.
- Replace rfd77402_result_polling() with read_poll_timeout().
- Add 'struct rfd77402_data' details in kernel-doc format.
- Arrange includes in order.
- Add comment for completion timeout value.
- Remove blank lines.
- Indent the comments to code.
- Convert mutex_init() to devm_mutex_init().
- Remove 'IRQF_TRIGGER_FALLING' flag from devm_request_threaded_irq().
- Drop the duplicate message.
- Replace 'dev_info' with 'dev_dbg()'.
- Update 'dev_id' to 'pdata' in rfd77402_interrupt_handler().
- Drop 'interrupt mode' comment
- Use 'if(ret)' instead of 'if(ret < 0) for consistency.
- Use 'return i2c_smbus_write_byte_data()' in 'rfd77402_config_irq'.
Link to v2: https://lore.kernel.org/all/20251130153712.6792-1-raskar.shree97@gmail.com/

v1 to v2:
- Fix commit message for dt-binding patch
- Update interrupt description in dt-binding
- Add 'vdd-supply' to 'required' property in dt-binding
- Add patch for moving polling implementation to helper
- Add helper rfd77402_wait_for_irq()
- Code refactoring
- Return failure if request IRQ fail
Link to v1: https://lore.kernel.org/all/20251126031440.30065-1-raskar.shree97@gmail.com/

---
Shrikant Raskar (6):
      iio: proximity: rfd77402: Reorder header includes
      iio: proximity: rfd77402: Align polling timeout with datasheet
      iio: proximity: rfd77402: Use kernel helper for result polling
      iio: proximity: rfd77402: Use devm-managed mutex initialization
      iio: proximity: rfd77402: Document device private data structure
      iio: proximity: rfd77402: Add interrupt handling support

 drivers/iio/proximity/rfd77402.c | 174 +++++++++++++++++++++++++++++++++------
 1 file changed, 147 insertions(+), 27 deletions(-)
---
base-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193
change-id: 20260121-b4-rfd77402_v5-558b8e28c387

Best regards,
-- 
Shrikant Raskar <raskar.shree97@gmail.com>


