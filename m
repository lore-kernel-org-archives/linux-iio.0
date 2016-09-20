Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:56804 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932385AbcITJrY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Sep 2016 05:47:24 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 1/2] staging: iio: isl29018: remove the FSF's mailing address
Date: Tue, 20 Sep 2016 05:38:56 -0400
Message-Id: <1474364337-13949-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Address warning from checkpatch:

CHECK: Do not include the paragraph about writing to the Free Software
Foundation's mailing address from the sample GPL notice. The FSF has
changed addresses in the past, and may do so again. Linux already
includes a copy of the GPL.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 76d9f74..ea4d7f1 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -15,10 +15,6 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.
  */
 
 #include <linux/module.h>
-- 
2.7.4

