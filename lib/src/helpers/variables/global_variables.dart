import 'package:get/get.dart';
import 'package:rrfx/src/components/languages/language_variable.dart';

class GlobalVariable {
  // static final mainURL = "https://api-tridentprofutures.techcrm.net";
  static final mainURL = "https://api-rrfx.techcrm.net";
  static final x_api_key = "fewAHdSkx28301294cKSnczdAs";
  static final namaPerusahaan = "PT. TridentPRO Berjangka Futures";
  static final List<String> gender = [LanguageGlobalVar.MEN.tr, LanguageGlobalVar.FEMALE.tr];
  static final List<String> genderIndo = ["Laki-laki", "Perempuan"];
  static final List<String> investExperienceEng = ["Yes", "No"];
  static final List<String> investExperienceIndo = ["Ya", "Tidak"];
  static final List<String> marital = [LanguageGlobalVar.SINGLE.tr, LanguageGlobalVar.MARRIED.tr, LanguageGlobalVar.DIVORCED.tr];
  static final List<String> maritalIndoVersion = ["Tidak Kawin", "Kawin", "Janda", "Duda"];
  static final List<String> relation = [LanguageGlobalVar.FATHER.tr, LanguageGlobalVar.MOTHER.tr, LanguageGlobalVar.YOUNR_BROTHER.tr, LanguageGlobalVar.BROTHER.tr];
  static final List<String> jobList = ["Government Employees", "Staff", "Supervisor", "Director", "Manager", "Housewife"];
  static final List<String> jobListIndo = ["Pejabat Lembaga Legislatif dan Pemerintah *", "Pegawai BUMN / BUMD (termasuk pensiunan)", "Pengusaha / Wiraswasta", "Pegawai Swasta", "PNS (termasuk pensiunan) *", "Profesional dan Konsultan", "TNI / Polri (termasuk pensiunan) *",
"Pegawai Bank",
"Pengurus Parpol *",
"Pengajar dan Dosen *",
"Pedagang",
"Pegawai Money Changer",
"Ibu Rumah Tangga",
"Pengurus / Pegawai LSM / Organisasi tidak berbadan hukum lainnya",
"Pengurus dan pegawai yayasan / lembaga berbadan hukum lainnya",
"Lain-Lain",
"Ulama / Pendeta / Pimpinan organisasi dan kelompok keagamaan",
"Pelajar / Mahasiswa",
"Buruh, Pembantu Rumah Tangga dan Tenaga Keamanan",
"Petani dan Nelayan",
"Pengrajin"];
  static final List<String> investmentGoal = ["Hedging", "Speculation", "Gain", "Other"];
  static final List<String> investmentGoalIndonesia = ["Lindungi Nilai", "Gain", "Spekulasi", "Lainnya"];
  static final List<String> jenisTabungan = ["Giro", "Tabungan"];
  static final List<String> tempatPenyelesaianPerselisihan = ["Badan Arbitrase Perdagangan Berjangka Komoditi (Bandung)", "Pengadilan Negeri Jakarta"];
  static final List<String> kantorCabangBerjangka = ["Jakarta Selatan", "Surabaya"];
  static final List<String> investmentExperience = ["I Never Invest", "I Have Tried Investing", "I Know What I'm Doing", "I Have Invested Many Times"];
  static final List<String> balanceSources = ["Salary", "Business", "Partner", "Parent", "Inheritance", "Investment", "Property", "Savings", "Other"];
  static final List<String> incomePerYear = ["Between 100 - 250 jt Rupiah", "Between 250 - 500 jt Rupiah", "Above 500 jt Rupiah"];
  static final List<String> incomePerYearIndo = ["Antara 100-250 juta", "Antara 250-500 juta", "Diatas 500 juta"];
  static final List<String> otherIncomePerYear = ["Between 100 - 250 jt Rupiah", "Between 250 - 500 jt Rupiah", "Above 500 jt Rupiah", "Not Have"];
  static final List<String> totalAssets = ["< 1 Billion Rupiah", "1 - 5 Billion Rupiah", "> 5 Billion Rupiah"];
  static final List<String> listSupportedDocuments = ["Cover Buku Tabungan (recommended)", "Tagihan Kartu Kredit", "Tagihan Listrik / Air", "Scan Kartu NPWP", "Rekening Koran Bank", "PBB / BPJS", "Lainnya"];
}